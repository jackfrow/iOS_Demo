//
//  JRUpdateDownload.h
//  36.AutoUpdate
//
//  Created by jackfrow on 2020/3/5.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRUpdateDownloadProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface JRUpdateDownload : NSObject

-(instancetype)initWithDelegate:(id<JRUpdateDownloadProtocol>)delegate;

-(void)startDownLoadWithUrlString:(NSString*)urlString;

@end

NS_ASSUME_NONNULL_END
