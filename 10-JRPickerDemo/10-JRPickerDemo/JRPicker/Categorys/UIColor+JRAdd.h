//
//  UIColor+JRAdd.h
//  10-JRPickerDemo
//
//  Created by jackfrow on 2019/4/16.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (JRAdd)

//字体设置灰色
+ (UIColor *)textGrayColor;

+ (UIColor *)CommonYellowColor;

+ (UIColor *)lineColor;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
