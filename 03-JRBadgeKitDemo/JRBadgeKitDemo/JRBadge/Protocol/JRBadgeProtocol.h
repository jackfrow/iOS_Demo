//
//  JRBadgeProtocol.h
//  JRBadgeKitDemo
//
//  Created by jackfrow on 2018/9/5.
//  Copyright © 2018年 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>

//key for associative methods during runtime
static char badgeLabelKey;
static char badgeBgKey;
static char badgeColorKey;
static char badgeRadiusKey;
static char badgeTextKey;
static char badgeFontKey;
static char badgeNumberKey;
static char badgeOffsetKey;

typedef NS_ENUM(NSInteger,JBadgeState){
    JBadgeStateHide = 0,
    JBadgeStateShow = 1,
    JBadgeStateUninitialized
};

typedef NS_ENUM(NSInteger,JBadgeStyle) {
    JBadgeStyleRedDot,
    JBadgeStyleNumber,
    JBadgeStyleNew,
    JBadgeStyleNecessary,
    JBadgeStyleCustom
};

@protocol JRBadgeProtocol <NSObject>

/**
 *  the badge label.
 */
@property (nonatomic,strong) UILabel * badge ;

/**
 * badgeColor,default is red.
 */

@property (nonatomic,strong) UIColor * badgeBgColor ;
/**
 *  text color,default is white.
 */
@property (nonatomic,strong) UIColor * badgeTextColor ;

/**
 *  Radius for badge & cornerRadius for red dot style.
 */
@property (nonatomic,assign) CGFloat badgeRadius;

/**
 *  badge current state, JBadgeState.
 */
-(JBadgeState)getBadgeState;

/**
 *  show badge with red dot with default style.
 */
-(void)showBadge;
/**
 *  hide the badge.
 */
-(void)hideBadge;
/**
 *  remove badge from view.
 */
-(void)removeBadge;

/**
 * make badge not hidden.n
 */
-(void)resumeBadge;


/**
 show badge

 @param style JBadgeStyle
 @param value number
 */
-(void)showBadgeWithStyle:(JBadgeStyle)style value:(NSInteger)value;

@end
