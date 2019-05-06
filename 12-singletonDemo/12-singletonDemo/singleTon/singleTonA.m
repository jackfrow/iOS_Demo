//
//  singleTonA.m
//  12-singletonDemo
//
//  Created by jackfrow on 2019/4/28.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "singleTonA.h"

static singleTonA* singleton = nil;

@implementation singleTonA

+(instancetype)sharedSingleTonA{
    
    @synchronized(self) {
        if (!singleton) {
            singleton = [[self alloc]init];
        }
    }
    return singleton;
    
}


+(void)reset{
    singleton = nil;
}

@end
