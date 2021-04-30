//
//  JYOPeration.swift
//  46.MutiThread
//
//  Created by jackfrow on 2021/4/30.
//

import Foundation




class OPreationDemo {
    
    //基础使用,当继承自Operation之后,调用start会调用main函数的方法
    func testDemo1()  {
        
        let op = JROPreation()
        op.start()
        
    }
    
    //使用block初始化
    
    func testDemo2()  {
        let op = BlockOperation {
            NSLog("this is a blockOperation")
        }
        op.start()
    }
    
    //通过OPreationQueue调用
    func testDemo3()  {
        OperationQueue().addOperation {
            NSLog("OperationQueue 进行调用")
        }
    }
    
    //获取主队列执行任务
    func testDemo4()  {
        //打印当前线程
        NSLog("currentThread---%@",Thread.current)
        NSLog("代码块------begin")
        
        //获取主队列
        let queue = OperationQueue.main
        queue.addOperation {
            Thread.sleep(forTimeInterval: 0.2)//执行耗时操作
            NSLog("任务1---%@", Thread.current)
        }
        
        queue.addOperation {
            Thread.sleep(forTimeInterval: 0.2)//执行耗时操作
            NSLog("任务2---%@", Thread.current)
        }
        
        NSLog("代码块------结束")
    }
    
    //设置队列的最大并发数
    func testDemo5()  {
        
        //打印当前线程
        NSLog("currentThread---%@",Thread.current)
        NSLog("代码块------begin")
        
        //创建并发队列
        let queue = OperationQueue()
//        queue.maxConcurrentOperationCount
        NSLog("maxConcurrentOperationCount = %d",queue.maxConcurrentOperationCount)
        //设置最大并发数
        queue.maxConcurrentOperationCount = 1
        
        let op1 = BlockOperation {
            for _ in 0..<2 {
                Thread.sleep(forTimeInterval: 0.5)//执行耗时操作
                NSLog("任务1---%@", Thread.current)
            }
        }
        
        let op2 = BlockOperation{
                for _ in 0..<2 {
                    Thread.sleep(forTimeInterval: 0.5)//执行耗时操作
                    NSLog("任务2---%@", Thread.current)
                }
            }
        
        queue.addOperations([op1,op2], waitUntilFinished: false)


        NSLog("代码块------结束")
        
    }
    
    
    //任务优先级
    func testDemo6()  {
        
        
        //打印当前线程
        NSLog("currentThread---%@",Thread.current)
        NSLog("代码块------begin")
        
        //创建并发队列
        let queue = OperationQueue()
//        queue.maxConcurrentOperationCount
        NSLog("maxConcurrentOperationCount = %d",queue.maxConcurrentOperationCount)
        //设置最大并发数
        queue.maxConcurrentOperationCount = 1
        
        let op1 = BlockOperation {
            for _ in 0..<2 {
                Thread.sleep(forTimeInterval: 0.5)//执行耗时操作
                NSLog("任务1---%@", Thread.current)
            }
        }
        op1.queuePriority = .low
        
        
        let op2 = BlockOperation{
                for _ in 0..<2 {
                    Thread.sleep(forTimeInterval: 0.5)//执行耗时操作
                    NSLog("任务2---%@", Thread.current)
                }
            }
        
        op2.queuePriority = .high
        
        let op3 = BlockOperation{
                for _ in 0..<2 {
                    Thread.sleep(forTimeInterval: 0.5)//执行耗时操作
                    NSLog("任务3---%@", Thread.current)
                }
            }
        op3.queuePriority = .normal
        
        queue.addOperations([op1,op2,op3], waitUntilFinished: false)


        NSLog("代码块------结束")
        
    }
    
    //操作依赖
    func testDemo7()  {
        
        //打印当前线程
        NSLog("currentThread---%@",Thread.current)
        NSLog("代码块------begin")
        
        //创建并发队列
        let queue = OperationQueue()
        
        let op1 = BlockOperation {
            for _ in 0..<2 {
                Thread.sleep(forTimeInterval: 0.5)//执行耗时操作
                NSLog("任务1---%@", Thread.current)
            }
        }
        
        let op2 = BlockOperation{
                for _ in 0..<2 {
                    Thread.sleep(forTimeInterval: 0.5)//执行耗时操作
                    NSLog("任务2---%@", Thread.current)
                }
            }
        
        let op3 = BlockOperation{
                for _ in 0..<2 {
                    Thread.sleep(forTimeInterval: 0.5)//执行耗时操作
                    NSLog("任务3---%@", Thread.current)
                }
            }
        
        op3.addDependency(op1)
        queue.addOperations([op1,op2,op3], waitUntilFinished: false)


        NSLog("代码块------结束")
    }
    
}





class JROPreation : Operation {
    
    
    override func main() {
        NSLog(" 继承自Operation的demo")
    }
    
}
