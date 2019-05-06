//
//  ViewController.m
//  11-load&initialize
//
//  Created by jackfrow on 2019/4/28.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "ClassB.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ClassB* cb = [[ClassB alloc] init];
    NSLog(@"cb = %@",cb.description);
    
    ClassB* cb2 =[[ClassB alloc] init];
    NSLog(@"cb2 = %@",cb2.description);
    
    
    
}


@end
