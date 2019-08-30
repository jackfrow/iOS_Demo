//
//  JRWindow.m
//  19.TouchEvents
//
//  Created by yy on 2019/8/30.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

#import "JRWindow.h"

@implementation JRWindow

-(void)sendEvent:(UIEvent *)event{
//    NSLog(@"%s调用时间戳 :\n%.2fms",__func__,CFAbsoluteTimeGetCurrent()*1000);
    [super sendEvent:event];
}

@end
