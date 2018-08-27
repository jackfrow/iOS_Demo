//
//  LockProtocol.h
//  01-ThreadLock
//
//  Created by jackfrow on 2018/8/21.
//  Copyright © 2018年 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LockProtocol <NSObject>

///常用方法展示
-(void)lockShows;

@optional
///对数据进行加锁
-(void)dataWithLock;

///对数据不加锁
-(void)dataWithOutLock;

///需要加锁处理的数据
@property (nonatomic,strong) NSMutableArray * dataSource ;

@end
