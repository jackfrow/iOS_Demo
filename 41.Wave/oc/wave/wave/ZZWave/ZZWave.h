//
//  ZZWave.h
//  wave
//
//  Created by jackfrow on 2021/4/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZWave : UIView

@property (nonatomic, copy) NSString *text;

-(void)startAnimation;


//初始偏移量
@property (nonatomic, assign) CGFloat waveOffset;

//波浪速度
@property (nonatomic, assign) CGFloat waveSpeed;

//波浪高度
@property (nonatomic, assign) CGFloat waveHeight;

//文字和波浪颜色
@property (nonatomic, strong) UIColor *color;

@end

NS_ASSUME_NONNULL_END
