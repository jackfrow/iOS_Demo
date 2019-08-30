//
//  AppDelegate.m
//  19.TouchEvents
//
//  Created by yy on 2019/8/29.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

#import "AppDelegate.h"
#import "JRWindow.h"
//参考文章:https://www.jianshu.com/p/c294d1bd963d
/*
 触摸发生时，系统内核生成触摸事件，先由IOKit处理封装成IOHIDEvent对象，通过IPC传递给系统进程SpringBoard，而后再传递给前台APP处理。
 事件传递到APP内部时被封装成开发者可见的UIEvent对象，先经过hit-testing寻找第一响应者，而后由Window对象将事件传递给hit-tested view，并开始在响应链上的传递。
 UIRespnder、UIGestureRecognizer、UIControl，笼统地讲，事件响应优先级依次递增。
 */


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[JRWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
      self.window.backgroundColor = [UIColor whiteColor];
      
      UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      UIViewController *vc = sb.instantiateInitialViewController;
      
      self.window.rootViewController = vc;
      [self.window makeKeyAndVisible];
    
    return YES;
}


@end
