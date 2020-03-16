//
//  ViewController.m
//  01-ThreadLock
//
//  Created by jackfrow on 2018/8/21.
//  Copyright © 2018年 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "NSLockDemo.h"
#import "MutiThreadUnsafeDemo.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//       SCPreferencesCreateWithAuthorization
    
        //    [self CallNSlock];
        //    [self CallConditionLock];
        //    [self CallRecursiveLock];
        //    [self CallCondition];
//    [self CallSynchronized];
//    [self Callsemaphore];
//    [self CallOSPinLock];
    
    MutiThreadUnsafeDemo* seller  = [[MutiThreadUnsafeDemo alloc] init];
//    [seller startSellTicket];
    [seller startSellTicketWithLock];
    
}


-(void)CallNSlock{
    
    NSLockDemo* demo = [[NSLockDemo alloc] init];
    //    [demo lockShows];
    //    [demo dataWithOutLock];
    [demo dataWithLock];
    
}

-(void)CallConditionLock{
    
    NSConditionLockDemo* demo = [[NSConditionLockDemo alloc] init];
    [demo lockShows];
    
}

-(void)CallRecursiveLock{
    NSRecursiveLockDemo* demo = [[NSRecursiveLockDemo alloc] init];
    [demo lockShows];
}

-(void)CallCondition{
    NSConditionDemo* demo = [[NSConditionDemo alloc] init];
    [demo lockShows];
}

-(void)CallSynchronized{
    
    NSSynchronizedDemo* demo = [[NSSynchronizedDemo alloc] init];
    [demo lockShows];
    
}

-(void)Callsemaphore{
    NSsemaphoreDemo* demo = [[NSsemaphoreDemo alloc] init];
    [demo lockShows];
}

-(void)CallOSPinLock{
    NSOSSpinLockDemo* demo = [[NSOSSpinLockDemo alloc] init];
    [demo lockShows];
}

@end

