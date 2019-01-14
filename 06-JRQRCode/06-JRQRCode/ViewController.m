//
//  ViewController.m
//  06-JRQRCode
//
//  Created by jackfrow on 2019/1/11.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "WCQRCodeVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (IBAction)ShowQrcode:(id)sender {
    
    WCQRCodeVC* vc = [[WCQRCodeVC alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
}

@end
