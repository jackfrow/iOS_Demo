//
//  ZHPerson.m
//  29.AutoReleasePoolDemo
//
//  Created by jackfrow on 2020/1/8.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "ZHPerson.h"

@implementation ZHPerson

-(void)dealloc
{
    NSLog(@"ZHPerson dealloc");
}
+(instancetype)object
{
    return [[ZHPerson alloc] init];
}

@end
