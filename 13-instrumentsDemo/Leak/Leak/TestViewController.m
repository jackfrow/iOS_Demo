//
//  TestViewController.m
//  CycleRefreshDemo
//
//  Created by jackfrow on 2018/8/1.
//  Copyright © 2018年 jackfrow. All rights reserved.
//

#import "TestViewController.h"
#import "TestModel.h"

@interface TestViewController ()

@property (nonatomic,strong) TestModel * model ;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.model = [[TestModel alloc] init];
    self.model.delegate = self;
    
//    NSMutableArray* firstArray = [NSMutableArray array];
//    NSMutableArray* secondeArray = [NSMutableArray array];
//    [firstArray addObject:secondeArray];
//    [secondeArray addObject:firstArray];
    
}

-(void)dealloc{
    
}


@end
