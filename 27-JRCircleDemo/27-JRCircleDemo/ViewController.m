//
//  ViewController.m
//  27-JRCircleDemo
//
//  Created by jackfrow on 2019/11/29.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "JRCircleView.h"
#import "UIColor+Hex.h"
@import Masonry;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"110918"];

    JRCircleView* circle = [[JRCircleView alloc] init];
    [self.view addSubview:circle];
    
    [circle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
    
}


@end
