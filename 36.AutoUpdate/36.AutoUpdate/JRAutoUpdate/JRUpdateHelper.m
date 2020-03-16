//
//  JRUpdateHelper.m
//  36.AutoUpdate
//
//  Created by jackfrow on 2020/3/6.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "JRUpdateHelper.h"
#import <AppKit/AppKit.h>

@implementation JRUpdateHelper

+(void)AutoUpdateWithAppName:(NSString *)appName zipPath:(NSString *)zipPath destPath:(NSString *)destPath{
    
    //1.unzip
    BOOL unzipSuccess = [self unzip:zipPath toPath:destPath];
    if (!unzipSuccess) {
        //deal Error
        return;
    }
    
    //2.lanch
    [self lanchAndInstallApp:[NSString stringWithFormat:@"%@/%@",destPath,appName] name:appName];
    
}

+(BOOL)unzip:(NSString*)zipPath toPath:(NSString*)destPath{
    
    BOOL success = NO;
      @try
      {
          NSTask *task = [[NSTask alloc] init];
          task.launchPath = @"/usr/bin/unzip";
          task.currentDirectoryPath = destPath;
          task.arguments = @[zipPath];

          [task launch];
          [task waitUntilExit];
          
//          [NSFileHandle new].fileDescriptor
          
          NSLog(@"standardOutput == %@",task.standardOutput);
          
          success = (task.terminationStatus == 0);
      }
      @catch (NSException *exception)
      {
          NSLog(@"exception: %@", exception);
      }
      return success;
    
}

+(void)lanchAndInstallApp:(NSString*)lanchPath name:(NSString*)name{
    
  
    NSWorkspace* ws = [NSWorkspace sharedWorkspace];
    BOOL lanchSuccess = [ws launchApplication:lanchPath];
    if (lanchSuccess) {
        
        [self installApp:lanchPath name:name];
        
    }else{
        //deal Error
        NSLog(@"lanched failed");
    }
    
}


+(void)installApp:(NSString*)appPath name:(NSString*)name{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    
    if ([manager fileExistsAtPath:[NSString stringWithFormat:@"/Applications/%@",name]]) {
        [manager removeItemAtPath:[NSString stringWithFormat:@"/Applications/%@",name] error:nil];
    }
    
    NSError* err = nil;
    
    if ([manager copyItemAtPath:appPath toPath:[NSString stringWithFormat:@"/Applications/%@",name] error:&err]) {
        //deal Success
        
        //exit
        [NSApp terminate:nil];
        
    }else{
        NSLog(@"err ==== %@",err);
        //deal error
    }

    
}


@end
