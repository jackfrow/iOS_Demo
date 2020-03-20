//
//  PacketTunnelProvider.m
//  VPNTunnelDemo
//
//  Created by jackfrow on 2020/3/2.
//Copyright © 2020 jackfrow. All rights reserved.
//

#import "PacketTunnelProvider.h"
#import "PotatsoBase.h"
#import "TunnelInterface.h"
#import "TunnelError.h"
#import "ProxyManager.h"


//#include <netdb.h>
//#include <arpa/inet.h>
#define REQUEST_CACHED @"requestsCached"    // Indicate that recent requests need update


@interface PacketTunnelProvider ()
@property NWTCPConnection *connection;
@property (strong) void (^pendingStartCompletion)(NSError *);
@end

@implementation PacketTunnelProvider

- (void)startTunnelWithOptions:(NSDictionary *)options completionHandler:(void (^)(NSError *))completionHandler
{

        [self openLog];
	    NSLog(@"starting potatso tunnel...");
        [self updateUserDefaults];
       NSError* error = [TunnelInterface setupWithPacketTunnelFlow:self.packetFlow];
    if (error) {
        completionHandler(error);
        exit(1);
        return;
    }
    
    self.pendingStartCompletion = completionHandler;
//    [self startProxies];
    
           
}


- (void)stopTunnelWithReason:(NEProviderStopReason)reason completionHandler:(void (^)(void))completionHandler
{
    
    NSLog(@"stopTunnelWithReason == %ld",(long)reason);
	completionHandler();
}

- (void)handleAppMessage:(NSData *)messageData completionHandler:(void (^)(NSData *))completionHandler
{
    
    NSLog(@"handleAppMessage = %@",[[NSString alloc] initWithData:messageData encoding:NSUTF8StringEncoding]);
	if (completionHandler != nil) {
		completionHandler(messageData);
	}
}

- (void)sleepWithCompletionHandler:(void (^)(void))completionHandler
{
	completionHandler();
}



#pragma mark - Util

-(void)openLog{
    
    NSString* logFilePath = [Potatso sharedLogUrl].path;
    [[NSFileManager defaultManager] createFileAtPath:logFilePath contents:nil attributes:nil];
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "w+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "w+", stderr);
    
}

- (void)updateUserDefaults {
    [[Potatso sharedUserDefaults] removeObjectForKey:REQUEST_CACHED];
    [[Potatso sharedUserDefaults] synchronize];
    [[Settings shared] setStartTime:[NSDate date]];
}


-(void)startProxies{
    [self startShadowsocks];
    [self startHttpProxy];
    [self startSocksProxy];
}

-(void)startShadowsocks{
    NSLog(@"startShadowsocks");
    [self syncStartProxy:@"shadowsocks" completion:^(dispatch_group_t g, NSError *__autoreleasing *proxyError) {
        
        [[ProxyManager sharedManager] startShadowsocks:^(int port, NSError * _Nonnull error) {
            *proxyError = error;
            dispatch_group_leave(g);
        }];
        
    }];
    
}

-(void)startHttpProxy{
    NSLog(@"startHttpProxy");
    [self syncStartProxy: @"http" completion:^(dispatch_group_t g, NSError *__autoreleasing *proxyError) {
          [[ProxyManager sharedManager] startHttpProxy:^(int port, NSError *error) {
              *proxyError = error;
              dispatch_group_leave(g);
          }];
      }];
}

-(void)startSocksProxy{
    NSLog(@"startSocksProxy");
    [self syncStartProxy: @"socks" completion:^(dispatch_group_t g, NSError *__autoreleasing *proxyError) {
           [[ProxyManager sharedManager] startSocksProxy:^(int port, NSError *error) {
               *proxyError = error;
               dispatch_group_leave(g);
           }];
       }];
}



#pragma mark - Help
- (void)syncStartProxy: (NSString *)name completion: (void(^)(dispatch_group_t g, NSError **proxyError))handler {
    dispatch_group_t g = dispatch_group_create();
    __block NSError *proxyError;
    dispatch_group_enter(g);
    handler(g, &proxyError);
    long res = dispatch_group_wait(g, dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2));
    if (res != 0) {
        proxyError = [TunnelError errorWithMessage:@"timeout"];
    }
    if (proxyError) {
        NSLog(@"start proxy: %@ error: %@", name, [proxyError localizedDescription]);
        exit(1);
        return;
    }
}

@end
