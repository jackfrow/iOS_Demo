//
//  HLSystemPermission.m
//  V-Hilife
//
//  Created by jackfrow on 2018/12/20.
//  Copyright © 2018 jackfrow. All rights reserved.
//

#import "HLSystemPermission.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@implementation HLSystemPermission

+ (BOOL)cameraAuthorized
{
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
        {
            NSDictionary* infoDict = [NSBundle mainBundle].infoDictionary;
            NSString* appName = [infoDict objectForKey:@"CFBundleDisplayName"];
            NSString* info =  [NSString stringWithFormat:@"Please allow %@ to access your camera in \"Settings -> Privacy -> Camera\"",appName];
            [[[UIAlertView alloc] initWithTitle:info message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];

            return NO;
        }

    return YES;
}

@end
