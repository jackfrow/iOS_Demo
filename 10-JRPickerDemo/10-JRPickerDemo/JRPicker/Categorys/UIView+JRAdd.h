//
//  UIView+JRAdd.h
//  10-JRPickerDemo
//
//  Created by jackfrow on 2019/4/16.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JRAdd)
//sets frame.origin.x = left;
@property (nonatomic) CGFloat left;
//sets frame.origin.y = top;
@property (nonatomic) CGFloat top;
//sets frame.origin.x = right - frame.size.wigth;
@property (nonatomic) CGFloat right;
//sets frame.origin.y = botton - frmae.size.height;
@property (nonatomic) CGFloat bottom;
//sets frame.size.width = width;
@property (nonatomic) CGFloat width;
//sets frame.size.height = height;
@property (nonatomic) CGFloat height;
//sets center.x = centerX;
@property (nonatomic) CGFloat centerX;
//sets center.y = centerY;
@property (nonatomic) CGFloat centerY;
//frame.origin
@property (nonatomic) CGPoint origin;
//frame.size
@property (nonatomic) CGSize size;
@end

NS_ASSUME_NONNULL_END
