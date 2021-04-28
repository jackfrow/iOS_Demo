//
//  GSTViewController.m
//  19.TouchEvents
//
//  Created by yy on 2019/8/29.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

#import "GSTViewController.h"
#import "JRTouchView.h"
#import "JRTapGestureRecognizer.h"

@interface GSTViewController ()

@end

@implementation GSTViewController

//总结：手势识别器比响应链具有更高的事件响应优先级。

/*
 A window delivers touch events to a gesture recognizer before it delivers them to the hit-tested view attached to the gesture recognizer. Generally, if a gesture recognizer analyzes the stream of touches in a multi-touch sequence and doesn’t recognize its gesture, the view receives the full complement of touches. If a gesture recognizer recognizes its gesture, the remaining touches for the view are cancelled.The usual sequence of actions in gesture recognition follows a path determined by default values of the cancelsTouchesInView, delaysTouchesBegan, delaysTouchesEnded properties.
 */

//手势识别器比UIResponder具有更高的事件响应优先级！！

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    JRTouchView* green = [[JRTouchView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    green.backgroundColor = [UIColor greenColor];
    [self.view addSubview:green];
    
    JRTapGestureRecognizer* tap = [[JRTapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTest)];
    [self.view addGestureRecognizer:tap];
    
    
//    UIPanGestureRecognizer* ges = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(actionPan)];
//    [self.view addGestureRecognizer:ges];
    
}


-(void)tapTest{
    
    NSLog(@"tapTest");
    
}


-(void)actionPan{
    NSLog(@"actionPan");
}

@end
