//
//  ViewController.m
//  JRBadgeKitDemo
//
//  Created by jackfrow on 2018/9/5.
//  Copyright © 2018年 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "UIView+JRBadge.h"

static int count = 5;

@interface ViewController ()

@property(weak, nonatomic) IBOutlet UIView *testView;

@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.testView setMaximumBadgeNumber:100000];
    [self.testView showBadge];

//    [self.testView showBadgeWithStyle:JBadgeStyleNecessary value:0];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {



    count += 1;
    [self.testView showBadgeCount:count];


}


@end
