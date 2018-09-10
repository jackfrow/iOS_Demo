//
//  ViewController.m
//  JRBadgeKitDemo
//
//  Created by jackfrow on 2018/9/5.
//  Copyright © 2018年 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "UIView+JRBadge.h"

@interface ViewController ()

@property(weak, nonatomic) IBOutlet UIView *testView;
@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self.testView showBadge];

    [self.view showBadge];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

//    JBadgeState state = self.testView.getBadgeState;
//
//    if (state == JBadgeStateUninitialized) {
//        [self.testView showBadge];
//    }else if (state == JBadgeStateShow){
//        [self.testView hideBadge];
//    }else if (state == JBadgeStateHide){
//        [self.testView resumeBadge];
//    }
    [self.testView showBadgeWithStyle:JBadgeStyleNew value:0];

}


@end
