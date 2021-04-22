//
//  AppDelegate.m
//  LanchH
//
//  Created by jackfrow on 2020/3/11.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
   // Insert code here to initialize your application
//    NSLog(@"ShadowsocksX-NG LaunchHelper");
//
    NSWorkspace* ws = [NSWorkspace sharedWorkspace];
//    BOOL bLaunched = NO;
//    bLaunched = [ws launchApplication: @"/Applications/LanchTest.app"];
    [ws openFile:@"/Applications/Tachyon Node Manager.app/Contents/MacOS/Tachyon Node Manager"];
//    [NSApp terminate:nil];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
   
}


@end

