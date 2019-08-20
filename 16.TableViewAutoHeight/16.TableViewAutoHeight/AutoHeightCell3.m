//
//  AutoHeightCell3.m
//  16.TableViewAutoHeight
//
//  Created by yy on 2019/8/20.
//  Copyright © 2019 xufanghao. All rights reserved.
//

#import "AutoHeightCell3.h"


/**
 多层嵌套的cell测试自动算高
 */
@interface AutoHeightCell3 ()

@property (weak, nonatomic) IBOutlet UIView *b3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *b3Height;

@end

@implementation AutoHeightCell3

-(void)random{

    self.b3Height.constant = arc4random_uniform(500) + 100;
    self.b3.backgroundColor = [self arndomColor];
}

- (UIColor *)arndomColor
{
    CGFloat red = arc4random_uniform(256)/ 255.0;
    CGFloat green = arc4random_uniform(256)/ 255.0;
    CGFloat blue = arc4random_uniform(256)/ 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return color;
}


@end
