//
//  ProxyManager.h
//  VPNTunnelDemo
//
//  Created by jackfrow on 2020/3/17.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SocksProxyCompletion)(int port, NSError * _Nullable error);
typedef void(^HttpProxyCompletion)(int port, NSError * _Nullable error);
typedef void(^ShadowsocksProxyCompletion)(int port,NSError  * _Nullable error);

@interface ProxyManager : NSObject

+ (ProxyManager *)sharedManager;

- (void)startSocksProxy: (SocksProxyCompletion)completion;
- (void)startShadowsocks: (ShadowsocksProxyCompletion)completion;
- (void)startHttpProxy:(HttpProxyCompletion)completion;

@end

NS_ASSUME_NONNULL_END
