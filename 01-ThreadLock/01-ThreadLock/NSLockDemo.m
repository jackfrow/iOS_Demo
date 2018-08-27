//
//  NSLockDemo.m
//  01-ThreadLock
//
//  Created by jackfrow on 2018/8/21.
//  Copyright © 2018年 jackfrow. All rights reserved.
//

//线程锁:如果在某个线程中，想对线程锁进行，但是线程锁已经被加锁的状态下，就可能出现线程挂起或者线程一直轮询的状态。

//锁是什么意思?  我们在使用多线程的多个线程可能会使用同一块资源，这样就很容易引发数据错乱和数据安全等问题，这时候就需要我们保证每次只有一个线程访问这一块资源，锁应运而生。

#import "NSLockDemo.h"

@implementation  NSBasicLock
@synthesize dataSource = _dataSource;

- (void)dataWithLock {
    //implete by sub class
}

- (void)dataWithOutLock {
    //implete by sub class
}

- (void)lockShows {
    //implete by sub class
}

-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = @[@"2",@"3"].mutableCopy;
    }
    return _dataSource;
}

@end

@implementation NSLockDemo


-(void)lockShows{

    NSLog(@"dataSource = %@",self.dataSource);
    
    //主线程中生成线程锁
    NSLock* lock = [[NSLock alloc] init];
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"lock = %@",lock.name);
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"%@",[NSThread currentThread]);
        [lock lock];
        NSLog(@"线程1");
        sleep(10);
        [lock unlock];
        NSLog(@"线程1解锁成功");
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);//确保线程2的任务在线程1的任务之后执行
        NSLog(@"%@",[NSThread currentThread]);
        [lock lock];
        NSLog(@"线程2");
        [lock unlock];
    });
    
    //在线程3中想要对线程锁进行加锁，但是因为线程1中已经对线程锁进行加锁了，所以这里会一直造成阻塞，一直到线程2加锁成功
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        sleep(2);//确保线程3的任务在线程2的任务之后执行
        NSLog(@"%@",[NSThread currentThread]);
        if ([lock tryLock]) {//尝试对线程锁进行加锁，能加锁则返回YES,不能加锁则返回NO,然后继续执行
            //       [lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];在加锁时间结束之前，一直尝试加锁，如果加锁成功，则继续执行
            [lock unlock];
        }else{
            NSLog(@"加锁失败");
        }
        
    });
    
}

-(void)dataWithOutLock{
    

    
    //如果不加锁可能造成数据错误
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (int i = 0 ;i < 10000 ; i++) {
            [self.dataSource addObject:@"1"];
            NSLog(@"dataSource = %@",self.dataSource);
        }
        
        NSLog(@"dataSource Complete = %@",self.dataSource);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (int i = 0; i < 10000 ; i++) {
            [self.dataSource removeLastObject];
            NSLog(@"dataSource = %@",self.dataSource);
        }
        
         NSLog(@"dataSource Complete = %@",self.dataSource);
        
    });
    
}

-(void)dataWithLock{
    
    NSLock* lock = [[NSLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [lock lock];
        
        [self.dataSource addObject:@"1"];

       NSLog(@"lock = %@",self.dataSource);
        
        [lock unlock];
        
     
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [lock lock];
        
        [self.dataSource removeLastObject];
        
        NSLog(@"lock2 = %@",self.dataSource);
        
        [lock unlock];
        
    });
    
}


@end

@implementation  NSConditionLockDemo


///NSConditionLock 和 NSLock 类似，都遵循 NSLocking 协议，方法都类似，只是多了一个 condition 属性，以及每个操作都多了一个关于 condition 属性的方法，例如 tryLock，tryLockWhenCondition:，NSConditionLock 可以称为条件锁，只有 condition 参数与初始化时候的 condition 相等，lock 才能正确进行加锁操作。而 unlockWithCondition: 并不是当 Condition 符合条件时才解锁，而是解锁之后，修改 Condition 的值，这个结论可以从下面的例子中得出。
-(void)lockShows{
 
    //主线程中
    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:0];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lockWhenCondition:1];
        NSLog(@"线程1");
        sleep(2);
        [lock unlock];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);//以保证让线程2的代码后执行
        if ([lock tryLockWhenCondition:0]) {
            NSLog(@"线程2");
            [lock unlockWithCondition:2];
            NSLog(@"线程2解锁成功");
        } else {
            NSLog(@"线程2尝试加锁失败");
        }
    });
    
    //线程3
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);//以保证让线程2的代码后执行
        if ([lock tryLockWhenCondition:2]) {
            NSLog(@"线程3");
            [lock unlock];
            NSLog(@"线程3解锁成功");
        } else {
            NSLog(@"线程3尝试加锁失败");
        }
    });
    
    //线程4
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3);//以保证让线程2的代码后执行
        if ([lock tryLockWhenCondition:2]) {
            NSLog(@"线程4");
            [lock unlockWithCondition:1];
            NSLog(@"线程4解锁成功");
        } else {
            NSLog(@"线程4尝试加锁失败");
        }
    });
    
    
}

@end


@implementation NSRecursiveLockDemo

///NSRecursiveLock 是递归锁，他和 NSLock 的区别在于，NSRecursiveLock 可以在一个线程中重复加锁（反正单线程内任务是按顺序执行的，不会出现资源竞争问题），NSRecursiveLock 会记录上锁和解锁的次数，当二者平衡的时候，才会释放锁，其它线程才可以上锁成功。
-(void)lockShows{
    NSRecursiveLock* lock = [[NSRecursiveLock alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveBlock)(int);
        RecursiveBlock = ^(int value){
            [lock lock];
            if (value >0) {
                NSLog(@"value:%d", value);
                RecursiveBlock(value - 1);
            }
        };
        RecursiveBlock(5);
    });
    
}

@end

@implementation NSConditionDemo
///NSCondition 的对象实际上作为一个锁和一个线程检查器，锁上之后其它线程也能上锁，而之后可以根据条件决定是否继续运行线程，即线程是否要进入 waiting 状态，经测试，NSCondition 并不会像上文的那些锁一样，先轮询，而是直接进入 waiting 状态，当其它线程中的该锁执行 signal 或者 broadcast 方法时，线程被唤醒，继续运行之后的方法。
-(void)lockShows{
    
    NSCondition *lock = [[NSCondition alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        while (!array.count) {
            
            [lock wait];
        }
        [array removeAllObjects];
        NSLog(@"array removeAllObjects");
        [lock unlock];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);//以保证让线程2的代码后执行
        
        [lock lock];
        [array addObject:@1];
        NSLog(@"array addObject:@1");
        [lock signal];
        [lock unlock];
    });

}

///使用场景:
//也就是使用 NSCondition 的模型为：
//
//锁定条件对象。
//
//测试是否可以安全的履行接下来的任务。
//
//如果布尔值是假的，调用条件对象的 wait 或 waitUntilDate: 方法来阻塞线程。 在从这些方法返回，则转到步骤 2 重新测试你的布尔值。 （继续等待信号和重新测试，直到可以安全的履行接下来的任务。waitUntilDate: 方法有个等待时间限制，指定的时间到了，则放回 NO，继续运行接下来的任务）
//
//如果布尔值为真，执行接下来的任务。
//
//当任务完成后，解锁条件对象。
//
//而步骤 3 说的等待的信号，既线程 2 执行 [lock signal] 发送的信号。
//
//其中 signal 和 broadcast 方法的区别在于，signal 只是一个信号量，只能唤醒一个等待的线程，想唤醒多个就得多次调用，而 broadcast 可以唤醒所有在等待的线程。如果没有等待的线程，这两个方法都没有作用。

@end

@implementation NSSynchronizedDemo

//@synchronized(object) 指令使用的 object 为该锁的唯一标识，只有当标识相同时，才满足互斥，所以如果线程 2 中的 @synchronized(self) 改为@synchronized(self.view)，则线程2就不会被阻塞，@synchronized 指令实现锁的优点就是我们不需要在代码中显式的创建锁对象，便可以实现锁的机制，但作为一种预防措施，@synchronized 块会隐式的添加一个异常处理例程来保护代码，该处理例程会在异常抛出的时候自动的释放互斥锁。@synchronized 还有一个好处就是不用担心忘记解锁了。

//如果在 @sychronized(object){} 内部 object 被释放或被设为 nil，从我做的测试的结果来看，的确没有问题，但如果 object 一开始就是 nil，则失去了锁的功能。不过虽然 nil 不行，但 @synchronized([NSNull null]) 是完全可以的。^ ^.

//@synchronized加锁标识应该是对地址进行加锁

- (void)lockShows{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(self) {
            sleep(2);
            NSLog(@"线程1");
        }
        NSLog(@"线程1解锁成功");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        @synchronized(self) {
            NSLog(@"线程2");
        }
    });
    
}

@end

@implementation NSsemaphoreDemo

//dispatch_semaphore 和 NSCondition 类似，都是一种基于信号的同步方式，但 NSCondition 信号只能发送，不能保存（如果没有线程在等待，则发送的信号会失效）。而 dispatch_semaphore 能保存发送的信号。dispatch_semaphore 的核心是 dispatch_semaphore_t 类型的信号量。
//
//dispatch_semaphore_create(1) 方法可以创建一个 dispatch_semaphore_t 类型的信号量，设定信号量的初始值为 1。注意，这里的传入的参数必须大于或等于 0，否则 dispatch_semaphore_create 会返回 NULL。
//
//dispatch_semaphore_wait(signal, overTime); 方法会判断 signal 的信号值是否大于 0。大于 0 不会阻塞线程，消耗掉一个信号，执行后续任务。如果信号值为 0，该线程会和 NSCondition 一样直接进入 waiting 状态，等待其他线程发送信号唤醒线程去执行后续任务，或者当 overTime  时限到了，也会执行后续任务。
//
//dispatch_semaphore_signal(signal); 发送信号，如果没有等待的线程接受信号，则使 signal 信号值加一（做到对信号的保存）。
//
//从上面的实例代码可以看到，一个 dispatch_semaphore_wait(signal, overTime); 方法会去对应一个 dispatch_semaphore_signal(signal); 看起来像 NSLock 的 lock 和 unlock，其实可以这样理解，区别只在于有信号量这个参数，lock unlock 只能同一时间，一个线程访问被保护的临界区，而如果 dispatch_semaphore 的信号量初始值为 x ，则可以有 x 个线程同时访问被保护的临界区。
-(void)lockShows{
    
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(signal, overTime);
        sleep(2);
        NSLog(@"线程1");
        
        dispatch_semaphore_signal(signal);
    });
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"线程2");
        dispatch_semaphore_signal(signal);
    });
    
    
}

@end

#import <libkern/OSAtomic.h>

@implementation NSOSSpinLockDemo

///拿上面的输出结果和上文 NSLock 的输出结果做对比，会发现 sleep(10) 的情况，OSSpinLock 中的“线程 2”并没有和”线程 1解锁成功“在一个时间输出，而是有一点时间间隔，所以 OSSpinLock 一直在做着轮询，而不是像 NSLock 一样先轮询，再 waiting 等唤醒。

-(void)lockShows{
    
      __block OSSpinLock theLock = OS_SPINLOCK_INIT;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        OSSpinLockLock(&theLock);
        NSLog(@"线程1");
        sleep(10);
        OSSpinLockUnlock(&theLock);
        NSLog(@"线程1解锁成功");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        OSSpinLockLock(&theLock);
        NSLog(@"线程2");
        OSSpinLockUnlock(&theLock);
    });
    
    
}

@end


#import <pthread.h>
@implementation NSPrethreadDemo

//int pthread_mutex_init(pthread_mutex_t * __restrict, const pthread_mutexattr_t * __restrict);
//首先是第一个方法，这是初始化一个锁，__restrict 为互斥锁的类型，传 NULL 为默认类型，一共有 4 类型。

//PTHREAD_MUTEX_NORMAL 缺省类型，也就是普通锁。当一个线程加锁以后，其余请求锁的线程将形成一个等待队列，并在解锁后先进先出原则获得锁。
//
//PTHREAD_MUTEX_ERRORCHECK 检错锁，如果同一个线程请求同一个锁，则返回 EDEADLK，否则与普通锁类型动作相同。这样就保证当不允许多次加锁时不会出现嵌套情况下的死锁。
//
//PTHREAD_MUTEX_RECURSIVE 递归锁，允许同一个线程对同一个锁成功获得多次，并通过多次 unlock 解锁。
//
//PTHREAD_MUTEX_DEFAULT 适应锁，动作最简单的锁类型，仅等待解锁后重新竞争，没有等待队列。


static pthread_mutex_t theLock;
- (void)example5 {
    pthread_mutex_init(&theLock, NULL);
    
    pthread_t thread;
    pthread_create(&thread, NULL, threadMethord1, NULL);
    
    pthread_t thread2;
    pthread_create(&thread2, NULL, threadMethord2, NULL);
}

void *threadMethord1() {
    pthread_mutex_lock(&theLock);
    printf("线程1\n");
    sleep(2);
    pthread_mutex_unlock(&theLock);
    printf("线程1解锁成功\n");
    return 0;
}

void *threadMethord2() {
    sleep(1);
    pthread_mutex_lock(&theLock);
    printf("线程2\n");
    pthread_mutex_unlock(&theLock);
    return 0;
}

//和 NSLock 的 lock unlock 用法一致，但还注意到有一个 pthread_mutex_trylock 方法，pthread_mutex_trylock 和 tryLock 的区别在于，tryLock 返回的是 YES 和 NO，pthread_mutex_trylock 加锁成功返回的是 0，失败返回的是错误提示码。
//
//pthread_mutex_destroy 为释放锁资源。
//
//至于 pthread_mutex_setprioceiling 和 pthread_mutex_getprioceiling，懵逼脸，这两个用来做什么不太理解。




@end
