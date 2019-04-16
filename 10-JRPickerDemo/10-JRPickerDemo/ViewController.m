//
//  ViewController.m
//  10-JRPickerDemo
//
//  Created by jackfrow on 2019/4/16.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "JRPicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    
}

- (IBAction)click:(id)sender {
    
    JRPickerModel* T1 = [JRPickerModel itemWithTitle:@"腾讯"];
    JRPickerModel* T2 = [JRPickerModel itemWithTitle:@"王者荣耀"];
    JRPickerModel* T3 = [JRPickerModel itemWithTitle:@"刺激战场"];
    [T1.subModels addObjectsFromArray:@[T2,T3]];
    
    JRPickerModel* Z1 = [JRPickerModel itemWithTitle:@"字节跳动"];
    JRPickerModel* Z2 = [JRPickerModel itemWithTitle:@"抖音"];
    JRPickerModel* Z3 = [JRPickerModel itemWithTitle:@"今日头条"];
    JRPickerModel* Z4 = [JRPickerModel itemWithTitle:@"火山小视频"];
    [Z1.subModels addObjectsFromArray:@[Z2,Z3,Z4]];
    
//    JRPickerModel* item2 = [JRPickerModel itemWithTitle:@"2"];
//    JRPickerModel* item3 = [JRPickerModel itemWithTitle:@"345"];
//    JRPickerModel* item4 = [JRPickerModel itemWithTitle:@"456"];
//    JRPickerModel* item5 = [JRPickerModel itemWithTitle:@"567"];
    
    [JRPickerView showWithSelectHandler:^(NSArray<JRPickerModel *> * _Nonnull models) {

        NSLog(@"select");
        NSLog(@"models = %@",models);

    } dateSource:@[T1,Z1] numberOfComponents:2];
    

    
}

@end
