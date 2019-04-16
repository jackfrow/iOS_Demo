//
//  NSArray+JRAdd.m
//  10-JRPickerDemo
//
//  Created by jackfrow on 2019/4/16.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "NSArray+JRAdd.h"

@implementation NSArray (JRAdd)
-(id)objectOrNilAtIndex:(NSUInteger)i{
    if (i < [self count]) {
        return [self objectAtIndex:i];
    }
    return nil;
}
@end
