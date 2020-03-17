//
//  Manager.h
//  PotatsoLibrary
//
//  Created by jackfrow on 2020/3/17.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Manager : NSObject

+ (Manager *)sharedManager;
-(void)regenerateConfigFiles;

@end

NS_ASSUME_NONNULL_END
