//
//  JRUpdateHelper.h
//  36.AutoUpdate
//
//  Created by jackfrow on 2020/3/6.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JRUpdateHelper : NSObject

+(void)AutoUpdateWithAppName:(NSString*)appName
                     zipPath:(NSString*)zipPath
                    destPath:(NSString*)destPath;


@end

NS_ASSUME_NONNULL_END
