//
//  ViewController.m
//  31.Proxy_demo
//
//  Created by jackfrow on 2020/2/26.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "BRLOptionParser.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}


- (IBAction)ChangeNetWork:(id)sender {
    
    NSLog(@"show change network");
    [self test];
    
}

-(int)test
{
    
    NSString* mode = @"global";
    NSString* portString = @"1086";;
    NSString* socks5ListenAddress = @"127.0.0.1";
    
    NSInteger port = 0;
    if (portString) {
        port = [portString integerValue];
        if (0 == port) {
            return 1;
        }
    }
    
    
    static AuthorizationRef authRef;
    static AuthorizationFlags authFlags;
    authFlags = kAuthorizationFlagDefaults
    | kAuthorizationFlagExtendRights
    | kAuthorizationFlagInteractionAllowed
    | kAuthorizationFlagPreAuthorize;
    OSStatus authErr = AuthorizationCreate(nil, kAuthorizationEmptyEnvironment, authFlags, &authRef);
    if (authErr != noErr) {
        authRef = nil;
        NSLog(@"Error when create authorization");
   
    } else {
        if (authRef == NULL) {
            NSLog(@"No authorization has been granted to modify network configuration");
           
        }
        
        SCPreferencesRef prefRef = SCPreferencesCreateWithAuthorization(nil, CFSTR("Shadowsocks"), nil, authRef);
        
        NSDictionary *sets = (__bridge NSDictionary *)SCPreferencesGetValue(prefRef, kSCPrefNetworkServices);
        
        NSMutableDictionary *proxies = [[NSMutableDictionary alloc] init];
        [proxies setObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCFNetworkProxiesHTTPEnable];
        [proxies setObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCFNetworkProxiesHTTPSEnable];
        [proxies setObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCFNetworkProxiesProxyAutoConfigEnable];
        [proxies setObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCFNetworkProxiesSOCKSEnable];
        [proxies setObject:@[] forKey:(NSString *)kCFNetworkProxiesExceptionsList];
        
        // 遍历系统中的网络设备列表，设置 AirPort 和 Ethernet 的代理
        for (NSString *key in [sets allKeys]) {
            NSMutableDictionary *dict = [sets objectForKey:key];
            NSString *hardware = [dict valueForKeyPath:@"Interface.Hardware"];
            //        NSLog(@"%@", hardware);
            BOOL modify = NO;
             if ([hardware isEqualToString:@"AirPort"]
                       || [hardware isEqualToString:@"Wi-Fi"]
                       || [hardware isEqualToString:@"Ethernet"]) {
                modify = YES;
            }
            
            if (modify) {
                
                NSString* prefPath = [NSString stringWithFormat:@"/%@/%@/%@", kSCPrefNetworkServices
                                      , key, kSCEntNetProxies];
                
                   if ([mode isEqualToString:@"global"]) {
                    
                    
                    [proxies setObject:socks5ListenAddress forKey:(NSString *)
                     kCFNetworkProxiesSOCKSProxy];
                    [proxies setObject:[NSNumber numberWithInteger:port] forKey:(NSString*)
                     kCFNetworkProxiesSOCKSPort];
                    [proxies setObject:[NSNumber numberWithInt:1] forKey:(NSString*)
                     kCFNetworkProxiesSOCKSEnable];
                    
                    SCPreferencesPathSetValue(prefRef, (__bridge CFStringRef)prefPath
                                              , (__bridge CFDictionaryRef)proxies);
                }
            }
        }
        
        SCPreferencesCommitChanges(prefRef);
        SCPreferencesApplyChanges(prefRef);
        SCPreferencesSynchronize(prefRef);
        
        AuthorizationFree(authRef, kAuthorizationFlagDefaults);
    }
    
    printf("pac proxy set to %s", [mode UTF8String]);
    
    return 0;
}



-(void)request2changeNetwork{
    
    
    NSString* mode = @"global";
    NSString* pacURL = @"";
    NSString* portString = @"1086";;
    NSString* socks5ListenAddress = @"127.0.0.1";
    
    
    NSInteger port = 0;
      if (portString) {
          port = [portString integerValue];
          if (0 == port) {
              return ;
          }
      }
    
    
    BRLOptionParser *options = [BRLOptionParser new];
    
    NSMutableSet* networkServiceKeys = [NSMutableSet set];
       [options addOption:"network-service" flag:'n' description:@"Manual specify the network profile need to set proxy." blockWithArgument:^(NSString* value){
           [networkServiceKeys addObject:value];
       }];
    
     NSMutableSet* proxyExceptions = [NSMutableSet set];
    [options addOption:"proxy-exception" flag:'x' description:@"Bypass proxy settings for this Host / Domain" blockWithArgument:^(NSString *value) {
         [proxyExceptions addObject:value];
     }];
    
//    127.0.0.1, localhost, 192.168.0.0/16, 10.0.0.0/8, FE80::/64, ::1, FD00::/8
    
    [proxyExceptions addObjectsFromArray:@[@"127.0.0.1",@"localhost",@"192.168.0.0/16",@"10.0.0.0/8",@"FE80::/64",@"FD00::/8"]];
    
AuthorizationRef authRef;
    AuthorizationFlags authFlags;
//    authFlags = kAuthorizationFlagDefaults;
    authFlags = kAuthorizationFlagDefaults
      | kAuthorizationFlagExtendRights
      | kAuthorizationFlagInteractionAllowed
      | kAuthorizationFlagPreAuthorize;
    OSStatus authErr =  AuthorizationCreate(nil, kAuthorizationEmptyEnvironment, authFlags, &authRef);
    
    if (authErr != noErr) {
        authRef = nil;
        NSLog(@"Error when create authorization");
        return;
    }else{
        if (authRef == NULL) {
            NSLog(@"No authorization has been granted to modify network configuration");
            return;
        }
        
        SCPreferencesRef prefRef = SCPreferencesCreateWithAuthorization(nil, CFSTR("Shadowsocks"), nil, authRef);
        
        NSDictionary *sets = (__bridge NSDictionary *)SCPreferencesGetValue(prefRef, kSCPrefNetworkServices);
        
//        NSLog(@"sets == %@",sets);
        
        NSMutableDictionary* proxies = [[NSMutableDictionary alloc] init];
        [proxies setObject:[NSNumber numberWithInt:0] forKey:(NSString*)kCFNetworkProxiesHTTPEnable];
        [proxies setObject:[NSNumber numberWithInt:0] forKey:(NSString*)kCFNetworkProxiesHTTPSEnable];
        [proxies setObject:[NSNumber numberWithInt:0] forKey:(NSString*)kCFNetworkProxiesProxyAutoConfigEnable];
        [proxies setObject:[NSNumber numberWithInt:0] forKey:(NSString*)kCFNetworkProxiesSOCKSEnable];
        [proxies setObject:@[] forKey:(NSString*)kCFNetworkProxiesExceptionsList];
        
//        NSLog(@"proxies == %@",proxies);
        
        
        for (NSString* key  in [sets allKeys]) {
            
            NSMutableDictionary *dict = [sets objectForKey:key];
//            NSLog(@"dict == %@",dict);
             NSString *hardware = [dict valueForKeyPath:@"Interface.Hardware"];
            
            NSLog(@"hardware ===== %@",hardware);
            
            BOOL modify = NO;
            if ([networkServiceKeys count] > 0) {
                if ([networkServiceKeys containsObject:key]) {
                    modify = YES;
                }
            }else if ([hardware isEqualToString:@"AirPort"] || [hardware isEqualToString:@"Wi-Fi"] || [hardware isEqualToString:@"Ethernet"]){
                modify = YES;
            }
            
            
            if (modify) {
                
                NSString* prefPath = [NSString stringWithFormat:@"/%@/%@/%@", kSCPrefNetworkServices
                                                   , key, kSCEntNetProxies];
                NSLog(@"prefPath == %@",prefPath);
                
                
                if ([mode isEqualToString:@"auto"]) {
                    
                    [proxies setObject:pacURL forKey:(NSString*)kCFNetworkProxiesProxyAutoConfigEnable];
                    [proxies setObject:[NSNumber numberWithInt:1] forKey:(NSString*)kCFNetworkProxiesProxyAutoConfigEnable];
                    
                    
                    SCPreferencesPathSetValue(prefRef, (__bridge CFStringRef)prefPath
                                                                , (__bridge CFDictionaryRef)proxies);
                    
                    
                }else if ([mode isEqualToString:@"global"]){
                    
                    [proxies setObject:socks5ListenAddress forKey:(NSString*)kCFNetworkProxiesSOCKSProxy];
                    [proxies setObject:[NSNumber numberWithInteger:port] forKey:(NSString*)kCFNetworkProxiesSOCKSPort];
                    [proxies setObject:[NSNumber numberWithInt:1] forKey:(NSString*)kCFNetworkProxiesSOCKSEnable];
                    [proxies setObject:[proxyExceptions allObjects] forKey:(NSString*)kCFNetworkProxiesExceptionsList];
                    
                    SCPreferencesPathSetValue(prefRef, (__bridge CFStringRef)prefPath
                    , (__bridge CFDictionaryRef)proxies);
                    
                    
                }else if ([mode isEqualToString:@"off"]){
                    
                }
                
                
                SCPreferencesCommitChanges(prefRef);
                SCPreferencesApplyChanges(prefRef);
                SCPreferencesSynchronize(prefRef);
                
                 AuthorizationFree(authRef, kAuthorizationFlagDefaults);
                
            }
            
            
        }
        
        printf("pac proxy set to %s", [mode UTF8String]);
        
    }
    
    
    
}



@end
