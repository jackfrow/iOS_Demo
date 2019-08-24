//
//  JROneViewController.m
//  17.ColdStart
//
//  Created by yy on 2019/8/23.
//  Copyright © 2019 xufanghao. All rights reserved.
//

#import "JROneViewController.h"
#import "BLStopwatch.h"

@interface JROneViewController ()

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL alreadyLoad;

@end

@implementation JROneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"JROneViewController");
    self.view.backgroundColor = [UIColor redColor];
    
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[BLStopwatch sharedStopwatch] splitWithDescription:@"启动测试"];
    [[BLStopwatch sharedStopwatch] stopAndPresentResultsThenReset];

}


@end
