//
//  XmVpnManagerModel.m
//  34.VPNDemo
//
//  Created by jackfrow on 2020/3/2.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "XmVpnManagerModel.h"

@implementation XmVpnManagerModel

- (void)configureInfoWithTunnelBundleId:(NSString *)tunnelBundleId serverAddress:(NSString *)serverAddress serverPort:(NSString *)serverPort mtu:(NSString *)mtu ip:(NSString *)ip subnet:(NSString *)subnet dns:(NSString *)dns {
    self.tunnelBundleId = tunnelBundleId;
    self.serverAddress  = serverAddress;
    self.serverPort     = serverPort;
    self.mtu            = mtu;
    self.ip             = ip;
    self.subnet         = subnet;
    self.dns            = dns;
}

@end
