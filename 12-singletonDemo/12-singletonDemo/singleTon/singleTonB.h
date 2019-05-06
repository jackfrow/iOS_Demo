//
//  singleTonB.h
//  12-singletonDemo
//
//  Created by jackfrow on 2019/4/28.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface singleTonB : NSObject

+(instancetype)sharedSingleTonB;

+(void)reset;

@end

NS_ASSUME_NONNULL_END
