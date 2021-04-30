//
//  Pthread.swift
//  46.MutiThread
//
//  Created by jackfrow on 2021/4/28.
//

import Foundation



func PthreadDemo1()  {
    // 1. 创建线程: 定义一个pthread_t类型变量
    var thread = pthread_t(nil)
    // 2. 开启线程: 执行任务
     pthread_create(&thread, nil, runForThread_1, nil)
    //设置子线程1的状态设置为detached，该线程运行结束后会自动释放所有资源
    pthread_detach(thread!);
}


// 需声明 Swift 类外
fileprivate func runForThread_1(_ arg: UnsafeMutableRawPointer) -> UnsafeMutableRawPointer? {
    
    NSLog("runForThread_1")
    return nil
}



func PthreadDemo2() {
    
    tickets.removeAll()
    for i in 0 ..< 100 {
        tickets.append(i)
    }
    
    
    //线程1 北京卖票窗口
     // 1. 创建线程1: 定义一个pthread_t类型变量
    var thread = pthread_t(nil)
     // 2. 开启线程1: 执行任务
    pthread_create(&thread, nil, run, nil)
     // 3. 设置子线程1的状态设置为detached，该线程运行结束后会自动释放所有资源
    pthread_detach(thread!);
     
     //线程2 上海卖票窗口
     // 1. 创建线程2: 定义一个pthread_t类型变量
    var thread2 = pthread_t(nil)
     // 2. 开启线程2: 执行任务
    pthread_create(&thread2, nil, run, nil)
     // 3. 设置子线程2的状态设置为detached，该线程运行结束后会自动释放所有资源
    pthread_detach(thread2!);

    
}

var mutex = pthread_mutex_t()
var tickets = [Int]()

fileprivate func run(_ arg: UnsafeMutableRawPointer) -> UnsafeMutableRawPointer? {
    
    
        while (true) {
            //锁门，执行任务
            pthread_mutex_lock(&mutex);
            if (tickets.count > 0) {
                
                NSLog("剩余票数%ld, 卖票窗口%@", tickets.count,Thread.current );
                _ = tickets.removeLast()
                Thread.sleep(forTimeInterval: 0.2)
              
            }
            else {
                NSLog("票已经卖完了");
                //开门，让其他任务可以执行
                pthread_mutex_unlock(&mutex);
                break;
            }
    
            //开门，让其他任务可以执行
            pthread_mutex_unlock(&mutex);
        }
    
    return nil
}





