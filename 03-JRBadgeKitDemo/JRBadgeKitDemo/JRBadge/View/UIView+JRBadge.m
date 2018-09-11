//
//  UIView+JRBadge.m
//  JRBadgeKitDemo
//
//  Created by jackfrow on 2018/9/5.
//  Copyright © 2018年 jackfrow. All rights reserved.
//


#import "UIView+JRBadge.h"
#import <objc/runtime.h>
#import <SpriteKit/SpriteKit.h>


#define JBadgeDefaultFont     ([UIFont boldSystemFontOfSize:12])


static const  CGFloat JRBadgeDefaultDotRadius = 4.0f;
static const  NSInteger JRBadgeMaximumNumber = 99;

@implementation UIView (JRBadge)

#pragma mark - API Method

-(void)showBadge{
#warning need directtion for red dot.
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

- (void)showBadgeCount:(NSInteger)badgeCount {
    [self showBadgeWithStyle:JBadgeStyleNumber value:badgeCount];
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
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame)+2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
        self.badge.font = JBadgeDefaultFont;
        [self.badge sizeToFit];//call system
        self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 3.0;
    }
    self.badge.hidden = NO;

}
-(void)showBadgeNumberWithValue:(NSInteger)value{
    if (value < 0){
        return;
    }

    [self badgeInit];

    self.badge.hidden = (value == 0);
    self.badge.tag = JBadgeStyleNumber;
    self.badge.font = self.badgeFont;
    self.badge.text = (value > self.maximumBadgeNumber) ?
            [[NSString alloc] initWithFormat:@"%d+",self.maximumBadgeNumber] :
            [NSString stringWithFormat:@"%d",value];
    [self adjustLabelWidth:self.badge];
    CGRect rect = self.badge.frame;
    rect.size.width += 4;
    rect.size.height += 4;
    if (CGRectGetWidth(rect) < CGRectGetHeight(rect)){//adjust when the width insufficient.
       rect.size.width = CGRectGetHeight(rect);
    }
    self.badge.frame = rect;
    self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 +self.badgeCenterOffset.x ,self.badgeCenterOffset.y);
    self.badge.layer.cornerRadius = CGRectGetHeight(rect)/2;

    

}
-(void)showNecessaryBadge{
    [self badgeInit];
    if (self.badge.tag != JBadgeStyleNecessary){
       self.badge.text = @"*";
       self.badge.tag = JBadgeStyleNecessary;
       self.badge.font = [UIFont systemFontOfSize:18];
       self.badge.textColor = UIColor.redColor;
       self.badge.backgroundColor = UIColor.clearColor;
        [self adjustLabelWidth:self.badge];
       self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
    }
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
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
        self.badge.layer.cornerRadius = JRBadgeDefaultDotRadius;
        self.badge.textAlignment = NSTextAlignmentCenter;
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



#pragma mark --  other private methods
- (void)adjustLabelWidth:(UILabel *)label
{
    [label setNumberOfLines:0];
    NSString *s = label.text;
    UIFont *font = [label font];
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize;
    
    if (![s respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
        
    } else {
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setLineBreakMode:NSLineBreakByWordWrapping];
        
        labelsize = [s boundingRectWithSize:size
                                    options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                 attributes:@{ NSFontAttributeName:font, NSParagraphStyleAttributeName : style}
                                    context:nil].size;
    }
    CGRect frame = label.frame;
    frame.size = CGSizeMake(ceilf(labelsize.width), ceilf(labelsize.height));
    [label setFrame:frame];
}

#pragma mark - setter/getter
-(UILabel *)badge{
    return objc_getAssociatedObject(self, &badgeLabelKey);
}

-(void)setBadge:(UILabel *)badge{
    objc_setAssociatedObject(self, &badgeLabelKey, badge, OBJC_ASSOCIATION_RETAIN);
}

- (UIFont *)badgeFont {
    return objc_getAssociatedObject(self, &badgeFontKey);
}

- (void)setBadgeFont:(UIFont *)badgeFont {
    objc_setAssociatedObject(self, &badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge){
       [self badgeInit];
    }
    self.badge.font = badgeFont;
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
    return objc_getAssociatedObject(self, &badgeColorKey);
}

-(void)setBadgeTextColor:(UIColor *)badgeTextColor{
    objc_setAssociatedObject(self, &badgeColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN);
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

- (NSString *)badgeText {
    return objc_getAssociatedObject(self, &badgeTextKey);

}
- (void)setBadgeText:(NSString *)badgeText {

    objc_setAssociatedObject(self, &badgeTextKey, badgeText , OBJC_ASSOCIATION_RETAIN);
    if (!self.badge){
       [self badgeInit];
    }
    self.badge.text = badgeText;
    self.badge.font = JBadgeDefaultFont;
    [self.badge sizeToFit];
}

- (NSInteger)maximumBadgeNumber {
    id obj = objc_getAssociatedObject(self, &badgeNumberKey);
    if (obj && [obj isKindOfClass:[NSNumber class]]){
        return [obj integerValue];
    } else{
        return JRBadgeMaximumNumber;
    }

}

- (void)setMaximumBadgeNumber:(NSInteger)maximumBadgeNumber {
    objc_setAssociatedObject(self, &badgeNumberKey, @(maximumBadgeNumber), OBJC_ASSOCIATION_RETAIN);
    if (self.badge == nil){
       [self badgeInit];
    }
}


- (CGPoint)badgeCenterOffset {

    id obj = objc_getAssociatedObject(self, &badgeOffsetKey);
    if (obj && [obj isKindOfClass:[NSDictionary class]] && [obj count]){
       CGFloat x = [[obj objectForKey:@"x"] floatValue];
       CGFloat y = [[obj objectForKey:@"y"] floatValue];
        return CGPointMake(x, y);
    }
    return CGPointZero;

}

- (void)setBadgeCenterOffset:(CGPoint)badgeCenterOffset {
    NSDictionary *centerInfo = @{@"x":@(badgeCenterOffset.x),@"y":@(badgeCenterOffset.y)};
    objc_setAssociatedObject(self, &badgeOffsetKey, centerInfo, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge){
        [self badgeInit];
    }
    self.badge.center = CGPointMake(CGRectGetWidth(self.frame)+2+badgeCenterOffset.x, badgeCenterOffset.y);
}

@end
