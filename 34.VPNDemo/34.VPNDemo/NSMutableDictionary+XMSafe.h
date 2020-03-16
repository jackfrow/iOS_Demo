//
//  NSMutableDictionary+XMSafe.h
//  34.VPNDemo
//
//  Created by jackfrow on 2020/3/2.
//  Copyright © 2020 jackfrow. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (XMSafe)

/**
    Safe set key-value for dictionary.
 */
- (void)safeSetObject:(id)aObj
               forKey:(id<NSCopying>)aKey;

/**
    Safe read value for key.
 */
- (id)safeObjectForKey:(id<NSCopying>)aKey;

@end

NS_ASSUME_NONNULL_END
