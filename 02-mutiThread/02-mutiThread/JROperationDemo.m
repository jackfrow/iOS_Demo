//
//  JROperationDemo.m
//  02-mutiThread
//
//  Created by jackfrow on 2018/8/24.
//  Copyright © 2018年 jackfrow. All rights reserved.
//

#import "JROperationDemo.h"

@implementation JROperationDemo

-(void)OperationBlock{
 
    //1.创建NSBlockOperation对象
    NSBlockOperation* operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"天王盖地虎，提莫1米5 = %@",[NSThread currentThread]);
    }];
    //2.创建多个block任务
    for (int i = 0 ; i < 10; i++) {
        [operation addExecutionBlock:^{
            NSLog(@"i = %d , %@",i,[NSThread currentThread]);
        }];

    }
    
    [operation start];
    
}

//队列
-(void)OperationQueue{
    //1.创建一个队列
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    //最大线程并发数
//    queue.maxConcurrentOperationCount = 1;
    //2.创建Operation
    NSBlockOperation* operation = [NSBlockOperation blockOperationWithBlock:^{
         NSLog(@"天王盖地虎，提莫1米5 = %@",[NSThread currentThread]);
    }];
    //3.创建多个Block任务
    for (int i = 0 ; i < 10; i++) {
        [operation addExecutionBlock:^{
            NSLog(@"i = %d , %@",i,[NSThread currentThread]);
        }];
    }
    [queue addOperation:operation];
    
}

//操作依赖
-(void)OperationDependency{
    //1.任务1:下载图片
    NSBlockOperation* op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片 - %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:1];
    }];
    //2.任务2:添加水印
    NSBlockOperation* op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"添加水印 - %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:1];
    }];
    //3.任务3:上传图片
    NSBlockOperation* op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"上传图片 - %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:1];
    }];
    //4.设置依赖
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    //5.创建队列并加入任务
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    [queue addOperations:@[op1,op2,op3] waitUntilFinished:NO];
}
#pragma mark - NSOperationQueue常用方法
//NSUInteger operationCount; //获取队列的任务数
//- (void)cancelAllOperations; //取消队列中所有的任务
//- (void)waitUntilAllOperationsAreFinished; //阻塞当前线程直到此队列中的所有任务执行完毕
//[queue setSuspended:YES]; // 暂停queue
//[queue setSuspended:NO]; // 继续queue

#pragma mark - 经典案例


@end
