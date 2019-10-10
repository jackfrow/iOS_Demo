//
//  DynamicSafe.m
//  25.PopDemo
//
//  Created by jackfrow on 2019/10/9.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "DynamicSafe.h"
#import "TestOne.h"
#import "TestTwo.h"
#import "TestThree.h"


@implementation DynamicSafe

-(void)fire{
    
    TestOne* one = [[TestOne alloc] init];
    TestTwo* two = [[TestTwo alloc] init];
    TestThree* three = [[TestThree alloc] init];
    
    NSArray* array = @[one,two,three];
    for (id obj  in array) {
        [obj myMethod];
    }
    
}

@end
