//
//  ViewController.m
//  LanchTest
//
//  Created by jackfrow on 2020/3/5.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)testLanch{
    
    //rm
        if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/LanchTest.app"]) {

            NSLog(@"removeItemAtPath");

          BOOL success =   [[NSFileManager defaultManager] removeItemAtPath:@"/Applications/LanchTest.app" error:nil];
            if (!success) {

                 showSystermAlert(@"delete failed");
                return;
            }

        }


    //mv
    BOOL success =   [[NSFileManager defaultManager] copyItemAtPath:@"/Users/jackfrow/Desktop/LanchTest2.app" toPath:@"/Applications/LanchTest.app" error:nil];

      if (!success) {
           showSystermAlert(@"mv failed");
      }
    
    NSWorkspace* ws = [NSWorkspace sharedWorkspace];
    
//    if ([ws launchApplication:@"/Applications/LanchTest.app"]) {
//
//        NSLog(@"lanchTest");
//        exit(0);
//
//    }
    
    
   NSString* path = [[NSBundle mainBundle] pathForResource:@"LanchH" ofType:@"app"];

    if ([ws openFile:path]) {
        NSLog(@"success");
    }
    
    exit(0);

    
    
}

-(void)mvAppInDock{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:@"/Dock"]) {
        NSLog(@"Exit");
    }
    
}

- (IBAction)lanch:(id)sender {
    
    [self testLanch];
    
//    [self mvAppInDock];
    
//    [self lanchApp];
//    [self copyApp];
//     showSystermAlert(@"this is a testing");
}

-(void)lanchApp{
    
    NSLog(@"Tachyon LaunchHelper");
    NSWorkspace* ws = [NSWorkspace sharedWorkspace];
    BOOL bLaunched = NO;
    
//    [ws openApplicationAtURL:[NSURL fileURLWithPath:@"/Applications/LanchTest.app"] configuration:[NSWorkspaceOpenConfiguration configuration] completionHandler:^(NSRunningApplication * _Nullable app, NSError * _Nullable error) {
//
//        NSLog(@"err = ");
//
//    }];
    
    
    bLaunched = [ws launchApplication:@"/Users/jackfrow/Library/Caches/rd.Tachyon-Server/PersistentDownloads/e1UZnQQXm/Tachyon Node Manager1.2/Tachyon Node Manager.app"];
//
    if (!bLaunched) {

        showSystermAlert(@"lanchecd failed");

    }else{
        NSLog(@"lanchedSuccess");
    }
    
     [NSApp terminate:nil];

    
}

-(void)copyApp{
    
    NSError* err ;

    
//    @"Dock"
    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/LanchTest.app"]) {
//
//        NSLog(@"removeItemAtPath");
//
//      BOOL success =   [[NSFileManager defaultManager] removeItemAtPath:@"/Applications/LanchTest.app" error:&err];
//        if (!success) {
//            NSLog(@"err === %@",err);
//             showSystermAlert(@"delete failed");
//            return;
//        }
//
//    }
    
//    [self lanchApp];
    
//    NSError* err = nil;
  BOOL success =   [[NSFileManager defaultManager] copyItemAtPath:@"/Users/jackfrow/Desktop/LanchTest2.app" toPath:@"/Applications/test.app" error:&err];
    
    if (!success) {
         showSystermAlert(@"mv failed");
    }
    
//    if (success) {
//        [self lanchApp];
//    }else{
//       showSystermAlert(@"mv failed");
//    }
    
    
//    /Users/jackfrow/Desktop/LanchTest.app

}

void showSystermAlert(NSString* content){
    
    NSAlert* alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"YES"];
    [alert setInformativeText:content];
    [alert setAlertStyle:NSAlertStyleWarning];
    [alert beginSheetModalForWindow:[NSApplication sharedApplication].keyWindow completionHandler:nil];
    
}

@end
