//
//  XmVpnManager.m
//  34.VPNDemo
//
//  Created by jackfrow on 2020/3/2.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "XmVpnManager.h"
#import "XmVpnManagerModel.h"
#import <NetworkExtension/NetworkExtension.h>
#import "NSMutableDictionary+XMSafe.h"

@interface XmVpnManager()

@property (nonatomic, strong) XmVpnManagerModel *vpnConfigurationModel;

@end

@implementation XmVpnManager


#pragma mark - Main Func Public
- (void)configManagerWithModel:(XmVpnManagerModel *)model {
    
    self.vpnConfigurationModel.serverAddress    = model.serverAddress;
    self.vpnConfigurationModel.serverPort       = model.serverPort;
    self.vpnConfigurationModel.mtu              = model.mtu;
    self.vpnConfigurationModel.ip               = model.ip;
    self.vpnConfigurationModel.subnet           = model.subnet;
    self.vpnConfigurationModel.dns              = model.dns;
    self.vpnConfigurationModel.tunnelBundleId   = model.tunnelBundleId;
    NSLog(@"XDXVPNManager, The vpn configuration tunnelBundleId is %s ,port is %s, server is %s, ip is %s, subnet is %s, mtu is %s, dns is %s",model.tunnelBundleId.UTF8String, model.serverPort.UTF8String, model.serverAddress.UTF8String, model.ip.UTF8String, model.subnet.UTF8String, model.mtu.UTF8String, model.dns.UTF8String);
    
    [self applyVpnConfiguration];
}


- (BOOL)startVPN {
    if (self.vpnManager.connection.status == NEVPNStatusDisconnected) {
        NSError *error;
//        [self.vpnManager.connection startVPNTunnelAndReturnError:&error];
        [self.vpnManager.connection startVPNTunnelWithOptions:@{@"test":@"a",@"testb":@"b"} andReturnError:&error];
        
        if (error != 0) {
            const char *errorInfo = [NSString stringWithFormat:@"%@",error].UTF8String;
            NSLog(@"XDXVPNManager, Start VPN Failed - %s !",errorInfo);
        }else {
            NSLog(@"XDXVPNManager, Start VPN Success !");
            return YES;
        }
    }else {
        NSLog(@"XDXVPNManager, Start VPN - The current connect status isn't NEVPNStatusDisconnected !");
    }
    
    return NO;
}

- (BOOL)stopVPN {
    if (self.vpnManager.connection.status == NEVPNStatusConnected) {
        [self.vpnManager.connection stopVPNTunnel];
        NSLog(@"XDXVPNManager, StopVPN Success - The current connect status is Connected.");
        return YES;
    }else  if (self.vpnManager.connection.status == NEVPNStatusConnecting) {
        [self.vpnManager.connection stopVPNTunnel];
        NSLog(@"XDXVPNManager,StopVPN Success - The current connect status is Connecting.");
    }else {
        NSLog(@"XDXVPNManager, StopVPN Failed - The current connect status isn't Connected or Connecting !");
    }
    
    return NO;
}

#pragma mark - Main Func Private

-(void)testSave{
    
    [NETunnelProviderManager loadAllFromPreferencesWithCompletionHandler:
        ^void (NSArray<NETunnelProviderManager *> *managers,NSError *error){
        
        if (error!=nil){
            NSLog(@"pxsztswn4x %@",error);
            return;
        }
        NETunnelProviderManager* manager;
        if (managers.count == 0){
            manager = [NETunnelProviderManager new];
        }else{
            [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"kmgVpnTunnelAuthSuccess"];
            return;
        }
        NETunnelProviderProtocol* newProtocol = [NETunnelProviderProtocol new];
        newProtocol.providerConfiguration = @{@"config":@""};
        manager.protocolConfiguration = newProtocol;
        manager.protocolConfiguration.serverAddress = @"127.0.0.1"; // 不允许不配置serverAddress
        manager.enabled = true;
//        cForGoVpnCertAlertShow();
        [manager saveToPreferencesWithCompletionHandler: ^void (NSError *error){
            if (error!=nil){

                NSLog(@"bght8d77f3 %@",error);
                return;
            }
            [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"kmgVpnTunnelAuthSuccess"];
                NSLog(@"kfhake2jwe start2");
        }];
    }];
    

    
}

- (void)applyVpnConfiguration {
    [NETunnelProviderManager loadAllFromPreferencesWithCompletionHandler:^(NSArray<NETunnelProviderManager *> * _Nullable managers, NSError * _Nullable error) {
        
        if (managers.count > 0) {
            self.vpnManager = managers[0];
            // 设置完成后更新主控制器的按钮状态
            if (self.delegate && [self.delegate respondsToSelector:@selector(loadFromPreferencesComplete)]) {
                [self.delegate loadFromPreferencesComplete];
            }
            NSLog(@"XDXVPNManager,The vpn already configured. We will use it.");
            return;
        }else {
            NSLog(@"XDXVPNManager ,The vpn config is NULL, we will config it later.");
        }
        
        [self.vpnManager loadFromPreferencesWithCompletionHandler:^(NSError * _Nullable error) {
            if (error != 0) {
                const char *errorInfo = [NSString stringWithFormat:@"%@",error].UTF8String;
                NSLog(@"XDXVPNManager,applyVpnConfiguration loadFromPreferencesWithCompletionHandler Failed - %s !",errorInfo);
                return;
            }
            
            NETunnelProviderProtocol *protocol = [[NETunnelProviderProtocol alloc] init];
            protocol.providerBundleIdentifier  = self.vpnConfigurationModel.tunnelBundleId;
            
            NSMutableDictionary *configInfo = [NSMutableDictionary dictionary];
            [configInfo safeSetObject:self.vpnConfigurationModel.serverPort       forKey:@"port"];
            [configInfo safeSetObject:self.vpnConfigurationModel.serverAddress    forKey:@"server"];
            [configInfo safeSetObject:self.vpnConfigurationModel.ip               forKey:@"ip"];
            [configInfo safeSetObject:self.vpnConfigurationModel.subnet           forKey:@"subnet"];
            [configInfo safeSetObject:self.vpnConfigurationModel.mtu              forKey:@"mtu"];
            [configInfo safeSetObject:self.vpnConfigurationModel.dns              forKey:@"dns"];
            
            protocol.providerConfiguration        = configInfo;
            protocol.serverAddress                = self.vpnConfigurationModel.serverAddress;
            self.vpnManager.protocolConfiguration = protocol;
            self.vpnManager.localizedDescription  = @"NEPacketTunnelVPNDemoConfig";
            
            [self.vpnManager setEnabled:YES];
            [self.vpnManager saveToPreferencesWithCompletionHandler:^(NSError * _Nullable error) {
                if (error != 0) {
                    const char *errorInfo = [NSString stringWithFormat:@"%@",error].UTF8String;
                    NSLog(@"XDXVPNManager, applyVpnConfiguration saveToPreferencesWithCompletionHandler Failed - %s !",errorInfo);
                }else {
                    [self applyVpnConfiguration];
                    NSLog(@"XDXVPNManager, save vpn configuration successfully !");
                }

            }];
        }];
    }];
}

@end
