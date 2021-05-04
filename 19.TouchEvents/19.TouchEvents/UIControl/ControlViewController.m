//
//  ControlViewController.m
//  19.TouchEvents
//
//  Created by yy on 2019/8/30.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

#import "ControlViewController.h"
#import "JRButton.h"
#import "JRTapGestureRecognizer.h"
#import "CustomControl.h"


@interface ControlViewController ()

@end

@implementation ControlViewController

//UIControl比其父视图上的手势识别器具有更高的事件响应优先级。
//UIControl实现响应同样用的是UIResponder的响应机制
//自定义的UIControl并不能阻止手势的识别

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    JRButton* btn = [[JRButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    CustomControl* btn = [[CustomControl alloc] initWithFrame:CGRectMake(100, 100, 100,100)];
    btn.backgroundColor = [UIColor blueColor];
//    [btn setTitle:@"test" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    JRTapGestureRecognizer* tap = [[JRTapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.view addGestureRecognizer:tap];
//
//    [btn addGestureRecognizer:tap];
}


-(void)tapClick{
    NSLog(@"tapClick");
}

-(void)btnClick:(UIButton*)sender{
    NSLog(@"btnClick");
}


@end
