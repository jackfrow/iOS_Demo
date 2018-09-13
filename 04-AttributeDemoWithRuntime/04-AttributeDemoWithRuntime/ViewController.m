//
//  ViewController.m
//  04-AttributeDemoWithRuntime
//
//  Created by jackfrow on 2018/9/12.
//  Copyright © 2018年 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

//说明：
//property_getAttributes函数返回objc_property_attribute_t结构体列表，objc_property_attribute_t结构体包含name和value，常用的属性如下：
//
//属性类型  name值：T  value：变化
//        编码类型  name值：C(copy) &(strong) W(weak)空(assign) 等 value：无
//        非/原子性 name值：空(atomic) N(Nonatomic)  value：无
//        变量名称  name值：V  value：变化

-(void)getAllProperty{

    unsigned  int propertyCount = 0;
    objc_property_t *propertyList =  class_copyPropertyList([Person class], &propertyCount);
    for (int i = 0; i < propertyCount; ++i) {
        objc_property_t property = propertyList[i];
        const char * name =  property_getName(property);
        const char * attribute = property_getAttributes(property);



        NSLog(@"属性的名称 = %s,属性的attribute = %s",name,attribute);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//   [self getAllIvarList];
//   [self getAllProperty];
     [self getIvarListWithClass:UIBarButtonItem .class];

     UIBarButtonItem *item =[[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonSystemItemAdd target:nil action:nil];
}


//
-(void)getAllIvarList{

     unsigned int methodCount = 0;
     Ivar *ivars = class_copyIvarList([Person class], &methodCount);
    for (int i = 0; i < methodCount; ++i) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSLog(@"实例变量的类型 = %s ，实例变量的名称 = %s",type,name);
    }
    free(ivars);


}



-(void)getIvarListWithClass:(Class)cls{

    unsigned int methodCount = 0;
    Ivar *ivars = class_copyIvarList(cls, &methodCount);
    for (int i = 0; i < methodCount; ++i) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSLog(@"实例变量的类型 = %s ，实例变量的名称 = %s",type,name);
    }
    free(ivars);

}

@end
