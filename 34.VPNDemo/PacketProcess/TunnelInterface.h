//
//  TunnelInterface.h
//  PacketProcess
//
//  Created by jackfrow on 2020/3/17.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>
@import NetworkExtension;

NS_ASSUME_NONNULL_BEGIN

@interface TunnelInterface : NSObject

+ (TunnelInterface *)sharedInterface;
+ (NSError *)setupWithPacketTunnelFlow:(NEPacketTunnelFlow *)packetFlow;

@end

NS_ASSUME_NONNULL_END
