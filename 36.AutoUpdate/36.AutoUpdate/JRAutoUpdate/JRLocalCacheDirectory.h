//
//  JRLocalCacheDirectory.h
//  36.AutoUpdate
//
//  Created by jackfrow on 2020/3/6.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JRLocalCacheDirectory : NSObject


+ (NSString *)cachePathForBundleIdentifier:(NSString *)bundleIdentifier;

+ (void)removeOldItemsInDirectory:(NSString *)directory;

+ (NSString * _Nullable)createUniqueDirectoryInDirectory:(NSString *)directory;

@end

NS_ASSUME_NONNULL_END
