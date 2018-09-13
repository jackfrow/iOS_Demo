//
// Created by jackfrow on 2018/9/12.
// Copyright (c) 2018 jackfrow. All rights reserved.
//

#import "UIBarButtonItem+JRBadge.h"

#define kActualView     [self getActualBadgeSuperView]

@implementation UIBarButtonItem (JRBadge)

- (void)showBadge {

}

#pragma mark -- private method

/**
 *  Because UIBarButtonItem is kind of NSObject, it is not able to directly attach badge.
    This method is used to find actual view (non-nil) inside UIBarButtonItem instance.
 *
 *  @return view
 */
- (UIView *)getActualBadgeSuperView
{
    return [self valueForKeyPath:@"_view"];//use KVC to hack actual view
}

@end