//
//  AppDelegate.m
//  LanchTest
//
//  Created by jackfrow on 2020/3/5.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
   
    [NSApp activateIgnoringOtherApps:true];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
   
}


void UnHideWithWindow(NSWindow *window){
    [window setCollectionBehavior: NSWindowCollectionBehaviorMoveToActiveSpace];
    [[[NSApplication sharedApplication] mainWindow] setCollectionBehavior:NSWindowCollectionBehaviorMoveToActiveSpace];
    [window makeKeyAndOrderFront:window];
    [NSApp activateIgnoringOtherApps:YES];
}

NSWindow* GetCurrentWindow(){
    return ((AppDelegate *)[NSApp delegate]).window;
}

void UnHideAndBringUiToFront(){
    UnHideWithWindow(GetCurrentWindow());
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag{
    UnHideAndBringUiToFront();
    return true;
}


@end
