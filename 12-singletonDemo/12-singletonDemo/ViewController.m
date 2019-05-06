//
//  ViewController.m
//  12-singletonDemo
//
//  Created by jackfrow on 2019/4/28.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "singleTon/singleTonA.h"
#import "singleTon/singleTonB.h"

//常见使用场景:
//• UIApplication
//• NSNotificationCenter
//• NSFileManager
//• NSUserDefaults
//• NSURLCache
//• NSHTTPCookieStorage

NSString* const destory = @"destory";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIApplication* app = [UIApplication sharedApplication];
    NSLog(@"app = %@",app);
    
    NSNotificationCenter* notifi = [NSNotificationCenter defaultCenter];
    [notifi addObserver:self selector:@selector(destory:) name:destory object:nil];
    
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSLog(@"fileManager = %@",fileManager);
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"userDefaults = %@",userDefaults);
    
    NSURLCache* cache = [NSURLCache sharedURLCache];
   
    NSLog(@"currentDiskUsage = %ld", cache.currentDiskUsage);
    NSLog(@"currentMemoryUsage = %ld", cache.currentMemoryUsage);
    
    NSHTTPCookieStorage* cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSLog(@"cookieStorage = %@",cookieStorage);
    

    
}



-(void)destory:(NSNotification*)info{
    
    NSLog(@"info = %@",info);


    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[NSNotificationCenter defaultCenter] postNotificationName:destory object:self userInfo:@{@"info":@"message"}];
}


- (IBAction)CreatSingle:(id)sender {
    
    singleTonA* singleA = [singleTonA sharedSingleTonA];
    NSLog(@"singleA = %@",singleA);
    singleTonB* singleB = [singleTonB sharedSingleTonB];
    NSLog(@"singleB = %@",singleB);
}

- (IBAction)resetSingle:(id)sender {
    
    [singleTonA reset];
    [singleTonB reset];
    
}


@end
