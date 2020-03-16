//
//  JRUpdateDownloadProtocol.h
//  36.AutoUpdate
//
//  Created by jackfrow on 2020/3/5.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JRUpdateDownloadProtocol <NSObject>

-(void)downLoadProgress:(CGFloat)progress;

- (void)downloaderDidFailWithError:(NSError *)error;

-(void)downloadFinishWithDestinationName:(NSString*)destinationName
                      temporaryDirectory:(NSString *)temporaryDirectory;


@end

NS_ASSUME_NONNULL_END
