//
//  XmVpnManager.h
//  34.VPNDemo
//
//  Created by jackfrow on 2020/3/2.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XmVpnManagerModel,NETunnelProviderManager;

@protocol XDXVPNManagerDelegate<NSObject>

- (void)loadFromPreferencesComplete;

@end

NS_ASSUME_NONNULL_BEGIN

@interface XmVpnManager : NSObject

@property (nonatomic, strong) NETunnelProviderManager *vpnManager;

@property (nonatomic, weak) id<XDXVPNManagerDelegate> delegate;

- (void)configManagerWithModel:(XmVpnManagerModel *)model;

/**
 *   Start VPN.
 *   If success return YES, otherwise return NO.
 */
- (BOOL)startVPN;

/**
 *  Stop VPN.
 *  If success return YES, otherwise return NO.
 */
- (BOOL)stopVPN;

-(void)testSave;

@end

NS_ASSUME_NONNULL_END
