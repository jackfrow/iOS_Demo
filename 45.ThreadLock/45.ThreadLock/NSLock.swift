//
//  NSLock.swift
//  45.ThreadLock
//
//  Created by jackfrow on 2021/4/28.
//

import Foundation


//MARK: - OSSpinLock
func OSSpinLockTest()  {
    var lock = OSSpinLock()

    DispatchQueue(label: "concurrent",attributes: .concurrent).async {
        NSLog("线程1 准备上锁")
        OSSpinLockLock(&lock)
        sleep(4)
        NSLog("线程1");
        OSSpinLockUnlock(&lock);
        NSLog("线程1 解锁成功");
        NSLog("--------------------------------------------------------");
    }
    
    
    
    DispatchQueue(label: "concurrent2",attributes: .concurrent).async {
        NSLog("线程2 准备上锁")
        OSSpinLockLock(&lock)
        sleep(3)
        NSLog("线程2");
        OSSpinLockUnlock(&lock);
        NSLog("线程2 解锁成功");
    }
    
}


func os_unfair_lockDemo() {
    var lock  = os_unfair_lock()
    DispatchQueue(label: "concurrent",attributes: .concurrent).async {
        NSLog("线程1 准备上锁")
        
        os_unfair_lock_lock(&lock)
        sleep(4)
        NSLog("线程1");
        
        os_unfair_lock_unlock(&lock)
        NSLog("线程1 解锁成功");
        NSLog("--------------------------------------------------------");
    }
    
    DispatchQueue(label: "concurrent2",attributes: .concurrent).async {
        NSLog("线程2 准备上锁")
        os_unfair_lock_lock(&lock)
        sleep(3)
        NSLog("线程2");
        os_unfair_lock_unlock(&lock);
        NSLog("线程2 解锁成功");
    }
    
    
}


//MARK: - 信号量

func semaphoreTest()  {
    let sigal = DispatchSemaphore(value: 1)
    DispatchQueue(label: "concurrent1",attributes: .concurrent).async {
        NSLog("线程1 等待ing");
        sigal.wait()//信号量-1
        NSLog("线程1");
        sleep(3)
        sigal.signal()//信号量加1
        NSLog("线程1 发送信号");
        NSLog("--------------------------------------------------------");
    }
    
    DispatchQueue(label: "concurrent2",attributes: .concurrent).async {
        NSLog("线程2 等待ing");
        sigal.wait()
         NSLog("线程2");
        sigal.signal()
         NSLog("线程2 发送信号");
    }
    
}



//MARK: - Pthread
func PthreadTest()  {
    var  pLock =  pthread_mutex_t()
    pthread_mutex_init(&pLock, nil)
    
    DispatchQueue(label: "concurrent1",attributes: .concurrent).async {
        NSLog("线程1 准备上锁");
         pthread_mutex_lock(&pLock);
         sleep(3);
         NSLog("线程1");
         pthread_mutex_unlock(&pLock);
    }
    
    DispatchQueue(label: "concurrent2",attributes: .concurrent).async {
        NSLog("线程2 准备上锁");
        pthread_mutex_lock(&pLock);
        NSLog("线程2");
        pthread_mutex_unlock(&pLock);
    }
    
}


//MARK: - pthread_mutex(recursive)
//pthread_mutex(recursive)
func PthreadRecursiveTest()  {
    
    var  pLock =  pthread_mutex_t()
    var attr = pthread_mutexattr_t()//设置属性
    pthread_mutexattr_init(&attr)
    pthread_mutexattr_settype(&attr,PTHREAD_MUTEX_RECURSIVE) //设置锁类型，这边是设置为递归锁
    pthread_mutex_init(&pLock, &attr);
    pthread_mutexattr_destroy(&attr); //销毁一个属性对象，在重新进行初始化之前该结构不能重新使用
    

    //1.线程1
    DispatchQueue(label: "concurrent2",attributes: .concurrent).async {
        RecursiveBlock(value: 5, lock: &pLock)
    }
    

    
}


fileprivate func RecursiveBlock(value :Int,lock:UnsafeMutablePointer<pthread_mutex_t>) {
    pthread_mutex_lock(lock)
    if value > 0 {
        NSLog("value: \(value)")
        RecursiveBlock(value: value-1, lock: lock)
    }
    pthread_mutex_unlock(lock)
}



//MARK: - NSLock

func NSLockDemo()  {
    
    let lock = NSLock()
    
    DispatchQueue(label: "concurrent1",attributes: .concurrent).async {
            NSLog("线程1 尝试加速ing...");
            lock.lock()
           sleep(3);//睡眠5秒
           NSLog("线程1");
            lock.unlock()
           NSLog("线程1解锁成功");
    }
    
    DispatchQueue(label: "concurrent2",attributes: .concurrent).async {
        NSLog("线程2 尝试加速ing...");
        let success = lock.lock(before: Date(timeIntervalSinceNow: 4))
        if (success){
            NSLog("线程2");
            lock.unlock()
            NSLog("线程2 解锁成功");
        }else{
            NSLog("失败")
        }
}

}

//MARK: - NSCondition

//等待一段时间自己醒过来
func NSConditionDemo1() {
    
    let lock  = NSCondition()
    DispatchQueue(label: "concurrent1",attributes: .concurrent).async {
       NSLog("start")
        lock.lock()
        NSLog("线程1加锁成功");
        lock.wait(until: Date(timeIntervalSinceNow: 2))
        NSLog("线程1")
        lock.unlock()
    }

}

//唤醒一个线程
func NSConditionDemo2()  {
    
    
    let lock = NSCondition()
    
    DispatchQueue(label: "concurrent1",attributes: .concurrent).async {
        lock.lock()
          NSLog("线程1加锁成功");
        lock.wait()
          NSLog("线程1");
        lock.unlock()
    }
    
    DispatchQueue(label: "concurrent2",attributes: .concurrent).async {
        lock.lock()
          NSLog("线程2加锁成功");
        lock.wait()
          NSLog("线程2");
        lock.unlock()
    }
    
    
    DispatchQueue(label: "concurrent2",attributes: .concurrent).async {
         sleep(2)
        NSLog("唤醒一个等待的线程")
        lock.signal()
    }
}

//唤醒所有线程
func NSConditionDemo3()  {
    
    let lock = NSCondition()
    
    DispatchQueue(label: "concurrent1",attributes: .concurrent).async {
        lock.lock()
          NSLog("线程1加锁成功");
        lock.wait()
          NSLog("线程1");
        lock.unlock()
    }
    
    DispatchQueue(label: "concurrent2",attributes: .concurrent).async {
        lock.lock()
          NSLog("线程2加锁成功");
        lock.wait()
          NSLog("线程2");
        lock.unlock()
    }
    
    
    DispatchQueue(label: "concurrent2",attributes: .concurrent).async {
         sleep(2)
        NSLog("唤醒一个等待的线程")
        lock.broadcast()
    }
    
}


//MARK: - NSRecursiveLock

func NSRecursiveLockDemo()  {
    let lock = NSRecursiveLock()
    NSRecursiveBlock(value: 10, lock: lock)
}


fileprivate func NSRecursiveBlock(value :Int,lock:NSRecursiveLock) {
    lock.lock()
    if value > 0 {
        NSLog("value: \(value)")
        NSRecursiveBlock(value: value-1, lock: lock)
    }
    lock.unlock()
}



//MARK: - synchronized
class Sync  {
   
    func SynchronizedDemo()  {
        
        DispatchQueue(label: "concurrent1",attributes: .concurrent).async {
            self.synchronized(lock:self ) {
                NSLog("进入线程1")
                sleep(2);
                NSLog("线程1");
            }
        }
        
        DispatchQueue(label: "concurrent2",attributes: .concurrent).async {
            self.synchronized(lock:self ) {
                NSLog("进入线程2")
                sleep(2);
                NSLog("线程2");
            }
        }
        
    }


    private func synchronized(lock: AnyObject, closure: () -> ()) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
}




//MARK: - NSConditionLock
//lock(whenCondition condition: Int):当条件相等时才会加锁成功,否者会一直卡在哪里,可以实现线程依赖的功能


func NSConditionLockDemo() {
    let lock = NSConditionLock(condition: 5)
    
    DispatchQueue(label: "concurrent1",attributes: .concurrent).async {
        if lock.tryLock(whenCondition: 1){
            NSLog("线程1");
        }else{
            NSLog("失败");
        }
    }
    
    DispatchQueue(label: "concurrent2",attributes: .concurrent).async {
        lock.lock(whenCondition: 3)
        NSLog("线程2")
        lock.unlock(withCondition: 4)
    }
    
    DispatchQueue(label: "concurrent3",attributes: .concurrent).async {
        sleep(1)
        lock.lock(whenCondition: 5)
        NSLog("线程3")
        lock.unlock(withCondition: 3)

    }
    
}
