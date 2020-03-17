//
//  TunnelError.m
//  VPNTunnelDemo
//
//  Created by jackfrow on 2020/3/17.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "TunnelError.h"

@implementation TunnelError

+ (NSError *)errorWithMessage:(NSString *)message {
    return [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier]code:100 userInfo:@{NSLocalizedDescriptionKey: message ? : @""}];
}

@end
