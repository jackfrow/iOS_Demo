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

@end
