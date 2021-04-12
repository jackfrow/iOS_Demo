//
//  ViewController.m
//  37.MemoryDemo
//
//  Created by jackfrow on 2020/5/27.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)Allocate:(id)sender {
    
    for (int i = 0; i < 1000; i++) {
        Size* s  =  malloc(1024*512);
        s[0] = 1;
        free(s);
    }
    
}


@end
