//
//  ViewController.m
//  30.TaggedPointer
//
//  Created by jackfrow on 2020/2/6.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
       NSNumber *number1 = @1;
       NSNumber *number2 = @2;
       NSNumber *number3 = @3;
       NSNumber *numberFFFF = @(0xFFFF);
       
       NSLog(@"number1 pointer is %p", number1);
       NSLog(@"number2 pointer is %p", number2);
       NSLog(@"number3 pointer is %p", number3);
       NSLog(@"numberffff pointer is %p", numberFFFF);
    
}


@end
