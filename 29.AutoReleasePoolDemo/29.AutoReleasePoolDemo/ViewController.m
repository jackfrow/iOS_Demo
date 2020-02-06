//
//  ViewController.m
//  29.AutoReleasePoolDemo
//
//  Created by jackfrow on 2020/1/8.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "ZHPerson.h"

//参考链接:https://juejin.im/post/5d807672f265da03c721d541
//https://blog.sunnyxx.com/2014/10/15/behind-autorelease/

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self test];
    
    
//    __weak id temp = nil;
//    {
//        ZHPerson *person = [[ZHPerson alloc] init];
//        temp = person;
//    }
//    NSLog(@"temp = %@",temp);
//
//    __weak id temp2 = nil;
//
//    {
//        ZHPerson* person = [ZHPerson object];
//        temp2 = person;
//    }
//    NSLog(@"temp2 = %@",temp2);

}

-(void)test{
    NSLog(@"strings");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    

}

@end
