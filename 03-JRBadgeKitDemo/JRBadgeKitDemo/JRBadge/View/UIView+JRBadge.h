//
//  UIView+JRBadge.h
//  JRBadgeKitDemo
//
//  Created by jackfrow on 2018/9/5.
//  Copyright © 2018年 jackfrow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRBadgeProtocol.h"


@interface UIView (JRBadge)<JRBadgeProtocol>
//the text in badgeLabel.
@property (nonatomic,copy) NSString *badgeText;
/*([UIFont boldSystemFontOfSize:12]) by default is not set.*/
@property (nonatomic, strong) UIFont *badgeFont ;
//max badge number,default is 99,if equal 2 zero,badge label hidden.
@property (nonatomic,assign) NSInteger maximumBadgeNumber;
/*{0,0} is default .*/
@property (nonatomic,assign) CGPoint badgeCenterOffset;

//prepare for show badge count;
-(void)showBadgeCount:(NSInteger)badgeCount;



@end
