//
//  TunnelError.h
//  VPNTunnelDemo
//
//  Created by jackfrow on 2020/3/17.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TunnelError : NSObject
+ (NSError *)errorWithMessage: (NSString *)message;
@end

NS_ASSUME_NONNULL_END
