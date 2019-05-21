//
//  ViewController.m
//  Leak
//
//  Created by jackfrow on 2019/5/21.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

- (IBAction)btnClick:(id)sender {
    
    TestViewController* vc = [[TestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
