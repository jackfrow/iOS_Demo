//
//  NSThread.swift
//  46.MutiThread
//
//  Created by jackfrow on 2021/4/28.
//

import Foundation


class JRThread : NSObject{
    


//NSThread有3种创建方式
/*
1.initWithTarget方式，先创建线程对象，再启动
2.detachNewThreadSelector显式创建并启动线程
3.performSelectorInBackground隐式创建并启动线程
 */


func NSThreadDemo1()  {
    
    //创建线程
    let thread = Thread(target: self , selector: #selector(run), object: nil)
    thread.name = "jackThread1"//name
    thread.threadPriority = 0.8//优先级
    thread.start()//启动
}
    

  @objc func run() {
        NSLog("当前线程%@",Thread.current);
   }


func NSThreadDemo2()  {
    // 使用类方法创建线程并自动启动线程
    Thread.detachNewThreadSelector(#selector(run), toTarget: self, with: nil)
    
}

func NSThreadDemo3()  {
    // 使用NSObject的方法隐式创建并自动启动
    performSelector(inBackground: #selector(run), with: nil)

}
    
    
}

