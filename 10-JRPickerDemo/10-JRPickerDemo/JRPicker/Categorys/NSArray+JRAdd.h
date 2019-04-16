//
//  NSArray+JRAdd.h
//  10-JRPickerDemo
//
//  Created by jackfrow on 2019/4/16.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (JRAdd)
//返回index位置的元素
-(id)objectOrNilAtIndex:(NSUInteger)i;
@end

NS_ASSUME_NONNULL_END
