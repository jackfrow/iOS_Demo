//
//  ViewController.m
//  18.CGGeometryDemo
//
//  Created by yy on 2019/8/24.
//  Copyright © 2019 xufanghao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//CGRectUnion:CGRectUnion接受两个CGRect结构体作为参数并且返回一个能够包含这两个矩形的最小矩形。
    CGRect frame1 = CGRectMake(50, 100.0, 150.0, 240.0);
    CGRect frame2 = CGRectMake(220.0, 240.0, 120.0, 120.0);
    CGRect frame3 = CGRectUnion(frame1, frame2);
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:frame1];
    [view1 setBackgroundColor:[UIColor redColor]];
    
    UIView *view2 = [[UIView alloc] initWithFrame:frame2];
    [view2 setBackgroundColor:[UIColor orangeColor]];
    
    UIView *view3 = [[UIView alloc] initWithFrame:frame3];
    [view3 setBackgroundColor:[UIColor grayColor]];
    
    [self.view addSubview:view3];
    [self.view addSubview:view2];
    [self.view addSubview:view1];
    
    
}


@end
