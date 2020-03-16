//
//  JRApplication.m
//  36.AutoUpdate
//
//  Created by jackfrow on 2020/3/6.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "JRApplication.h"

@implementation JRApplication


+(NSString *)bundleIdentifier{

    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    
}

+(NSString *)appName{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

+(NSString *)appVersion{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

@end
