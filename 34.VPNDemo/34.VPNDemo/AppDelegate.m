//
//  AppDelegate.m
//  34.VPNDemo
//
//  Created by jackfrow on 2020/3/2.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
   
     signal(SIGPIPE, SIG_IGN);
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];//这里的bundle 写nil也可以代表是mainBundle
    ViewController* vc = storyboard.instantiateInitialViewController;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    
    return YES;
}





@end
