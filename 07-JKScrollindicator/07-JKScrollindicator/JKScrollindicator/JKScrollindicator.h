//
//  JKScrollindicator.h
//  07-JKScrollindicator
//
//  Created by jackfrow on 2019/1/23.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JKScrollindicator : UIView

//外层颜色
@property (nonatomic,strong) UIColor * backGroundColor ;

//内部颜色
@property (nonatomic,strong) UIColor * innerColor ;

//设置滚动进度
@property (nonatomic,assign) CGFloat progress;

@end


