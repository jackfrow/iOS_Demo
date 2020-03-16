//
//  NSMutableDictionary+XMSafe.m
//  34.VPNDemo
//
//  Created by jackfrow on 2020/3/2.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "NSMutableDictionary+XMSafe.h"


@implementation NSMutableDictionary (XMSafe)

- (void)safeSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key) {
        return ;
    }
    
    if (!obj) {
        [self removeObjectForKey:key];
    }else {
        [self setObject:obj forKey:key];
    }
}

- (void)safeSetObject:(id)aObj forKey:(id<NSCopying>)aKey {
    if (aObj && ![aObj isKindOfClass:[NSNull class]] && aKey) {
        [self setObject:aObj forKey:aKey];
    } else {
        return;
    }
}

- (id)safeObjectForKey:(id<NSCopying>)aKey {
    if (aKey != nil) {
        return [self objectForKey:aKey];
    } else {
        return nil;
    }
}


@end
