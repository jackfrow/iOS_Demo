//
//  UIView+JRBadge.m
//  JRBadgeKitDemo
//
//  Created by jackfrow on 2018/9/5.
//  Copyright © 2018年 jackfrow. All rights reserved.
//


#import "UIView+JRBadge.h"
#import <objc/runtime.h>


#define JBadgeDefaultFont     ([UIFont boldSystemFontOfSize:12])



static const  CGFloat JRBadgeDefaultDotRadius = 4.0f;

@implementation UIView (JRBadge)

#pragma mark - API Method

-(void)showBadge{
    [self showBadgeWithStyle:JBadgeStyleRedDot value:0];
}

-(void)hideBadge{
    self.badge.hidden = YES;
}

-(void)removeBadge{
    [self.badge removeFromSuperview];
    self.badge = nil;
}

-(void)resumeBadge{
    if (self.badge && self.badge.hidden == YES) {
        self.badge.hidden = NO;
    }
}

-(JBadgeState)getBadgeState{
    if (self.badge == nil) return JBadgeStateUninitialized;
    return self.badge.hidden == YES ? JBadgeStateHide : JBadgeStateShow;
}

- (void)showBadgeWithStyle:(JBadgeStyle)style value:(NSInteger)value {
    switch (style) {
        case JBadgeStyleRedDot:
            [self showRedDotBadge];
         break;
         case JBadgeStyleNumber:
            [self showBadgeNumberWithValue:value];
        break;
        case JBadgeStyleNew:
            [self showNewBadge];
            break;
        case JBadgeStyleNecessary:
            [self showNecessaryBadge];
            break;
        case JBadgeStyleCustom:
            [self showCustomBadge];
            break;
        default:
            break;
    }
}




#pragma mark - PrivateMethod
-(void)showRedDotBadge{
    [self badgeInit];
    //if badge style is not redDot,Update UI
    if (self.badge.tag != JBadgeStyleRedDot) {
        self.badge.text = @"";
        self.badge.tag = JBadgeStyleRedDot;
        [self updateBadgeFrame];
        self.badge.layer.cornerRadius = CGRectGetWidth(self.badge.frame) / 2.0;
    }
    self.badge.hidden = NO;
}
-(void)updateBadgeFrame{
    //center is fixed,just modify size.
    self.badge.frame = CGRectMake(self.badge.center.x - self.badgeRadius, self.badge.center.y - self.badgeRadius, 2 * self.badgeRadius, 2 * self.badgeRadius);
}

-(void)showNewBadge{
    [self badgeInit];
    if (self.badge.tag != JBadgeStyleNew) {
        self.badge.text = @"new";
        self.badge.tag = JBadgeStyleNew;
#warning  adding badge center offset. the custom style.
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame)+2, 0);
        self.badge.font = JBadgeDefaultFont;
        [self.badge sizeToFit];//call system
        self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 3.0;
    }
    self.badge.hidden = NO;

    
}
-(void)showBadgeNumberWithValue:(NSInteger)value{
    [self badgeInit];
}
-(void)showNecessaryBadge{
    [self badgeInit];
}
-(void)showCustomBadge{
    [self badgeInit];
    //implement by sub class. wait for use.
}


-(void)badgeInit{
    
    if (self.badgeBgColor == nil) {
        self.badgeBgColor = UIColor.redColor;
    }
    if (self.badgeTextColor == nil) {
        self.badgeTextColor = UIColor.whiteColor;
    }

    if (nil == self.badge) {
        CGFloat redotWidth = JRBadgeDefaultDotRadius * 2;
        CGRect rect = CGRectMake(0, 0, redotWidth, redotWidth);
        self.badge = [[UILabel alloc] initWithFrame:rect];
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2, 0);
        self.badge.layer.cornerRadius = JRBadgeDefaultDotRadius;
        self.badge.layer.masksToBounds = YES;//Open crop
        self.badge.backgroundColor = self.badgeBgColor;
        self.badge.textColor = self.badgeTextColor;
        self.badge.tag = JBadgeStyleRedDot;//default is red dot.
        self.badge.hidden = NO;
        self.badge.text = @"";
        [self addSubview:self.badge];
        [self bringSubviewToFront:self.badge];//move badge to top.
    }
}


#pragma mark - setter/getter
-(UILabel *)badge{
    return objc_getAssociatedObject(self, &badgeLabelKey);
}

-(void)setBadge:(UILabel *)badge{
    objc_setAssociatedObject(self, &badgeLabelKey, badge, OBJC_ASSOCIATION_RETAIN);
}

-(UIColor *)badgeBgColor{
    return objc_getAssociatedObject(self, &badgeBgKey);
}

-(void)setBadgeBgColor:(UIColor *)badgeBgColor{
    objc_setAssociatedObject(self, &badgeBgKey, badgeBgColor, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
    self.badge.backgroundColor = badgeBgColor;
}

-(UIColor *)badgeTextColor{
    return objc_getAssociatedObject(self, &badgeTextKey);
}

-(void)setBadgeTextColor:(UIColor *)badgeTextColor{
    objc_setAssociatedObject(self, &badgeTextKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
    self.badge.textColor = badgeTextColor;
}

//change badge radius
-(CGFloat)badgeRadius{
    return [objc_getAssociatedObject(self, &badgeRadiusKey) floatValue];
}

-(void)setBadgeRadius:(CGFloat)badgeRadius{
    objc_setAssociatedObject(self, &badgeRadiusKey, @(badgeRadius), OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
}

@end