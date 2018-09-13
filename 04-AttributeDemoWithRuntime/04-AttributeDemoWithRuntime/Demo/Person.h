//
// Created by jackfrow on 2018/9/12.
// Copyright (c) 2018 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


@interface Person : NSObject


//姓名
@property (nonatomic,copy) NSString* name;
//年龄
@property (nonatomic,assign) CGFloat age;
//性别
@property (nonatomic,copy) NSString* gender;

@end