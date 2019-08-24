//
//  AppDelegate.m
//  17.ColdStart
//
//  Created by yy on 2019/8/23.
//  Copyright © 2019 xufanghao. All rights reserved.
//

#import "AppDelegate.h"
#import "JRTabBarController.h"
#import "BLStopwatch.h"

//冷启动总结:https://jackfrow.github.io/2019/08/23/2019-8-23-APP冷启动/

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    NSLog(@"didFinishLaunchingWithOptions 开始执行");
    [[BLStopwatch sharedStopwatch] start];
    
    //首屏渲染
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    JRTabBarController* vc = [JRTabBarController new];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
 
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0 ; i < 100000; i ++ ) {
            NSLog(@"i === %d",i);
        }
    });

    NSLog(@"didFinishLaunchingWithOptions 执行完成");
    
    return YES;
}



@end
