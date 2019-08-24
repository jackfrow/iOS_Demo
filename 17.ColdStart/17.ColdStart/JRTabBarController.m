//
//  JRTabBarController.m
//  17.ColdStart
//
//  Created by yy on 2019/8/23.
//  Copyright © 2019 xufanghao. All rights reserved.
//

#import "JRTabBarController.h"
#import "JROneViewController.h"
#import "JRTwoViewController.h"
#import "JRThreeViewController.h"


@interface JRTabBarController ()

@end

@implementation JRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"JRTabBarController");
    
    JROneViewController* one = [[JROneViewController alloc] init];
    UINavigationController* oneNav = [[UINavigationController alloc] initWithRootViewController:one];
    [self addChildViewController:oneNav];
    
    JRTwoViewController* two = [[JRTwoViewController alloc] init];
    two.view.backgroundColor = [UIColor greenColor];
    UINavigationController* twoNav = [[UINavigationController alloc] initWithRootViewController:two];
    [self addChildViewController:twoNav];
    
    JRThreeViewController* three = [[JRThreeViewController alloc] init];
    three.view.backgroundColor = [UIColor yellowColor];
    UINavigationController* threeNav = [[UINavigationController alloc] initWithRootViewController:three];
    [self addChildViewController:threeNav];
    

    
}



@end
