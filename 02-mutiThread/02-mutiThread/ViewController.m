//
//  ViewController.m
//  02-mutiThread
//
//  Created by jackfrow on 2018/8/24.
//  Copyright © 2018年 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "JROperationDemo.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self syncInMainQueue];
//    [self mixQueueAndDispatch];
//    [self GroupQueue];
    [self CallOperation];
}

//调用Operation
-(void)CallOperation{
    JROperationDemo* demo = [[JROperationDemo alloc] init];
//    [demo OperationBlock];
//    [demo OperationQueue];
    [demo OperationDependency];
}

//在主队列中同步执行方法(线程死锁)
-(void)syncInMainQueue{
    NSLog(@"1 == %@",[NSThread currentThread]);
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"3 == %@",[NSThread currentThread]);
    });
    NSLog(@"2 == %@",[NSThread currentThread]);
}
//解释：
//同步任务会阻塞当前线程，然后把 Block 中的任务放到指定的队列中执行，只有等到 Block 中的任务完成后才会让当前线程继续往下运行。
//dispatch_sync 立即阻塞当前的主线程，然后把 Block 中的任务放到 main_queue 中，可是 main_queue 中的任务会被取出来放到主线程中执行，但主线程这个时候已经被阻塞了，所以 Block 中的任务就不能完成，它不完成，dispatch_sync 就会一直阻塞主线程，这就是死锁现象。导致主线程一直卡死。
//混合执行
-(void)mixQueueAndDispatch{
    
   dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue1, ^{
            NSLog(@"1 == %@",[NSThread currentThread]);
//        dispatch_sync(queue1, ^{
//             NSLog(@"2 == %@",[NSThread currentThread]);
//        });
        
    });
    NSLog(@"3 == %@",[NSThread currentThread]);
}


//队列组
-(void)GroupQueue{
    //1.创建队列组
    dispatch_group_t group = dispatch_group_create();
    //2.创建队列
    dispatch_queue_t queue = dispatch_queue_create("global", DISPATCH_QUEUE_CONCURRENT);
    
    //3.多次使用队列组的方法执行任务, 只有异步方法
    //3.1.执行3次循环
    dispatch_group_async(group, queue, ^{
        
        for (NSInteger i = 0; i < 3; i++) {
            NSLog(@"group-01 - %@", [NSThread currentThread]);
        }
        
    });
    //3.2 主队列执行8次循环
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < 8; i++) {
            NSLog(@"group-02 - %@", [NSThread currentThread]);
        }
    });
    NSLog(@"testThread == %@",[NSThread currentThread]);
    //3.3 执行5次循环
    dispatch_group_async(group, queue, ^{
        for (NSInteger i = 0; i < 5; i++) {
            NSLog(@"group-03 - %@", [NSThread currentThread]);
        }
    });
    
    //4.所有任务执行完成后通知
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
           NSLog(@"完成 - %@", [NSThread currentThread]);
    });
    

}



@end
