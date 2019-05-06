//
//  singleTonB.m
//  12-singletonDemo
//
//  Created by jackfrow on 2019/4/28.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "singleTonB.h"

static singleTonB* singleton = nil;
static dispatch_once_t onceToken;

@implementation singleTonB

+(instancetype)sharedSingleTonB{
    
    
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

+ (void)reset{
    
    singleton = nil;
    onceToken = 0;
    
}

@end
