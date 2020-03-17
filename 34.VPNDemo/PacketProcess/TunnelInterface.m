//
//  TunnelInterface.m
//  PacketProcess
//
//  Created by jackfrow on 2020/3/17.
//  Copyright © 2020 jackfrow. All rights reserved.
//
//PacketProcessor

#import "TunnelInterface.h"

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
//        _udpSession = [NSMutableDictionary dictionaryWithCapacity:5];
//        _udpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_queue_create("udp", NULL)];
    }
    return self;
}

@end
