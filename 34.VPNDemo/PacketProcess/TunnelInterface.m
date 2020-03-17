//
//  TunnelInterface.m
//  PacketProcess
//
//  Created by jackfrow on 2020/3/17.
//  Copyright © 2020 jackfrow. All rights reserved.
//
//PacketProcessor

#import "TunnelInterface.h"

@import CocoaAsyncSocket;
#define kTunnelInterfaceErrorDomain [NSString stringWithFormat:@"%@.TunnelInterface", [[NSBundle mainBundle] bundleIdentifier]]


@interface TunnelInterface ()<GCDAsyncUdpSocketDelegate>

@property (nonatomic) NEPacketTunnelFlow *tunnelPacketFlow;
@property (nonatomic) NSMutableDictionary *udpSession;
@property (nonatomic) GCDAsyncUdpSocket *udpSocket;
@property (nonatomic) int readFd;
@property (nonatomic) int writeFd;

@end

@implementation TunnelInterface

+ (TunnelInterface *)sharedInterface {
    static dispatch_once_t onceToken;
    static TunnelInterface *interface;
    dispatch_once(&onceToken, ^{
        interface = [TunnelInterface new];
    });
    return interface;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        _udpSession = [NSMutableDictionary dictionaryWithCapacity:5];
        _udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_queue_create("udp", NULL)];
    }
    return self;
}

+(NSError *)setupWithPacketTunnelFlow:(NEPacketTunnelFlow *)packetFlow{
    
    if (packetFlow == nil) {
        return [NSError errorWithDomain:kTunnelInterfaceErrorDomain code:1 userInfo:@{NSLocalizedDescriptionKey: @"PacketTunnelFlow can't be nil."}];
    }
    [TunnelInterface sharedInterface].tunnelPacketFlow = packetFlow;
    
    NSError* error;
    GCDAsyncUdpSocket *udpSocket = [TunnelInterface sharedInterface].udpSocket;
     [udpSocket bindToPort:0 error:&error];
    if (error) {
         return [NSError errorWithDomain:kTunnelInterfaceErrorDomain code:1 userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"UDP bind fail(%@).", [error localizedDescription]]}];
     }
      [udpSocket beginReceiving:&error];
    if (error) {
          return [NSError errorWithDomain:kTunnelInterfaceErrorDomain code:1 userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"UDP bind fail(%@).", [error localizedDescription]]}];
      }
    
    int fds[2];
     if (pipe(fds) < 0) {
         return [NSError errorWithDomain:kTunnelInterfaceErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey: @"Unable to pipe."}];
     }
     [TunnelInterface sharedInterface].readFd = fds[0];
     [TunnelInterface sharedInterface].writeFd = fds[1];
     return nil;

}

@end
