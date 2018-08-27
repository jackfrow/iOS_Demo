//
//  MutiThreadUnsafeDemo.h
//  01-ThreadLock
//
//  Created by jackfrow on 2018/8/23.
//  Copyright © 2018年 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MutiThreadUnsafeDemo : NSObject

//经典的卖票场景来模拟多线程操作引发的数据异常
-(void)startSellTicket;

-(void)startSellTicketWithLock;

@end
