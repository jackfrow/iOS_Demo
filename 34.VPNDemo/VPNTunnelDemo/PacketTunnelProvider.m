//
//  PacketTunnelProvider.m
//  VPNTunnelDemo
//
//  Created by jackfrow on 2020/3/2.
//Copyright © 2020 jackfrow. All rights reserved.
//

#import "PacketTunnelProvider.h"
//#import "PotatsoBase.h"

#include <netdb.h>
#include <arpa/inet.h>


@interface PacketTunnelProvider ()
@property NWTCPConnection *connection;
@property (strong) void (^pendingStartCompletion)(NSError *);
@end

@implementation PacketTunnelProvider

- (void)startTunnelWithOptions:(NSDictionary *)options completionHandler:(void (^)(NSError *))completionHandler
{
//
//        [self openLog];
	    NSLog(@"starting potatso tunnel...");
           
}


- (void)stopTunnelWithReason:(NEProviderStopReason)reason completionHandler:(void (^)(void))completionHandler
{
	completionHandler();
}

- (void)handleAppMessage:(NSData *)messageData completionHandler:(void (^)(NSData *))completionHandler
{
	if (completionHandler != nil) {
		completionHandler(messageData);
	}
}

- (void)sleepWithCompletionHandler:(void (^)(void))completionHandler
{
	completionHandler();
}



#pragma mark - Util
//-(void)openLog{
//    
//    NSString* logFilePath = [Potatso sharedLogUrl].path;
//    [[NSFileManager defaultManager] createFileAtPath:logFilePath contents:nil attributes:nil];
//    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "w+", stdout);
//    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "w+", stderr);
//    
//}

//-(void)

@end
