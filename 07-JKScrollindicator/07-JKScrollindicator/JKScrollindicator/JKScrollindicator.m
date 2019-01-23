//
//  JKScrollindicator.m
//  07-JKScrollindicator
//
//  Created by jackfrow on 2019/1/23.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "JKScrollindicator.h"

static const float backGroundRadius = 2.0f;
static const float innerRadius = 1.5f;

@implementation UIView (JKExtension)
- (void)setJk_x:(CGFloat)jk_x
{
    CGRect frame = self.frame;
    frame.origin.x = jk_x;
    self.frame = frame;
}
@end

@interface JKScrollindicator()

@property (nonatomic,strong) UIView * backGroundView ;//容器背景

@property (nonatomic,strong) UIView * innerView ;//滚动条

@property (nonatomic,assign) CGFloat innerHeight;//滚动条的高度

@end

@implementation JKScrollindicator


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CommonInit];
    }
    return self;
}


#pragma mark - Private
-(void)CommonInit{
    
    self.backGroundColor = UIColor.lightGrayColor;
    self.innerColor = UIColor.greenColor;
    self.innerHeight = 3;
    
    self.backGroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.backGroundView.layer.cornerRadius = backGroundRadius;
    self.backGroundView.backgroundColor = self.backGroundColor;
    [self addSubview:self.backGroundView];
    
    self.innerView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.backGroundView.bounds.size.height - self.innerHeight)/2.0, 20, self.innerHeight)];
    self.innerView.layer.cornerRadius = innerRadius;
    self.innerView.backgroundColor = self.innerColor;
    [self addSubview:self.innerView];
    
    
}

#pragma mark - Methods
-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    if (progress > 1) {
        progress = 1;
    }else if (progress < 0){
        progress = 0;
    }
    
    CGFloat totalRollingrange = self.backGroundView.bounds.size.width - self.innerView.bounds.size.width;
    [self.innerView setJk_x:totalRollingrange * progress];
    
}



@end



