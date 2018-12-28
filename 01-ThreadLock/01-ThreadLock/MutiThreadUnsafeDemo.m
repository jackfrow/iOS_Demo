//
//  MutiThreadUnsafeDemo.m
//  01-ThreadLock
//
//  Created by jackfrow on 2018/8/23.
//  Copyright © 2018年 jackfrow. All rights reserved.
//

#import "MutiThreadUnsafeDemo.h"

@interface MutiThreadUnsafeDemo()

//所有的票
@property (nonatomic,assign) NSInteger totalTicket;

@end

@implementation MutiThreadUnsafeDemo


//不加锁售票
-(void)startSellTicket{
    
    self.totalTicket = 5;
    NSThread* t1 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicket) object:nil];
    t1.name = @"售票员1";
    
    NSThread* t2 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicket) object:nil];
    t2.name = @"售票员2";
    
    [t1 start];
    [t2 start];
    
}

//售票方法
-(void)sellTicket{
    //获取当前线程
    NSThread * currentThread = [NSThread currentThread];
    
    //方法中的数据会被拷贝到栈中去.
    //一直卖票,直到票数为0
    while(1){
         NSInteger total = self.totalTicket;
        NSLog(@"当前线程%@,total的地址 = %p,totalTicket的地址 = %p",currentThread,&total,&self->_totalTicket);
        if(self.totalTicket > 0){
            NSLog(@"%@使用的对象地址是%p",currentThread,&total);
            //让当前线程睡眠0.1秒
            [NSThread sleepForTimeInterval:0.1];
            //打印卖票日志
            NSLog(@"%@卖出一张票,票号为%ld",currentThread,(long)self.totalTicket);
            //票数减一
            self.totalTicket = self.totalTicket - 1;
        }else{
            NSLog(@"票卖完了.%@",currentThread);
            break;
        }
    }
}

-(void)startSellTicketWithLock{
    
    self.totalTicket = 5;
    NSThread* t1 = [[NSThread alloc] initWithTarget:self selector:@selector(selleTicketWithLock) object:nil];
    t1.name = @"售票员1";
    
    NSThread* t2 = [[NSThread alloc] initWithTarget:self selector:@selector(selleTicketWithLock) object:nil];
    t2.name = @"售票员2";
    
    [t1 start];
    [t2 start];
    
}


//加锁售票
-(void)selleTicketWithLock{
    
    //获取当前线程
    NSThread * currentThread = [NSThread currentThread];
    
    //一直卖票,直到票数为0
    while(1){
        @synchronized(self){//加上锁之后，如果A线程在使用该锁，那么当B线程想要使用该锁时，B线程就会被挂起,当A线程使用完线程锁时，B线程就会被唤起，并且更新资源。
        NSInteger total = self.totalTicket;
        NSLog(@"当前线程%@,total的地址 = %p,totalTicket的地址 = %p",currentThread,&total,&self->_totalTicket);
            if(self.totalTicket > 0){
                 NSLog(@"%@使用的对象地址是%p",currentThread,&total);
                //让当前线程睡眠0.1秒
                [NSThread sleepForTimeInterval:0.1];
                //打印卖票日志
                NSLog(@"%@卖出一张票,票号为%ld",currentThread,(long)self.totalTicket);
                //票数减一
                self.totalTicket = --total;
            }else{
                NSLog(@"票卖完了.%@",currentThread);
                break;
            }

        }
    }
    
}



@end
