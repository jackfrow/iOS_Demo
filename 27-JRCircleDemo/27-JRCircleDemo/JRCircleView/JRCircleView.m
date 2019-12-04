//
//  JRCircleView.m
//  27-JRCircleDemo
//
//  Created by jackfrow on 2019/11/29.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "JRCircleView.h"
#import "UIColor+Hex.h"
#import "Masonry.h"

@interface JRCircleView ()

@property (nonatomic, strong) UIButton *imageBtn;
@property (nonatomic, strong) CAShapeLayer *ForwardLayer;
@property (nonatomic, strong) CAShapeLayer *ReverseLayer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) BOOL statusConnet;

@end

//1F1928
@implementation JRCircleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configure];
        [self setupViews];
        [self setupContrails];
    }
    return self;
}

-(void)configure{
    
    self.bounds = CGRectMake(0, 0, 200, 200);
    self.backgroundColor = [UIColor colorWithHexString:@"1F1928"];
    self.clipsToBounds = true;
    self.layer.cornerRadius = 100;
    
}

-(void)setupViews{
    [self addSubview:self.imageBtn];
    self.ForwardLayer =  [self addGraidLayerWithView:self CloskWise:true];
    self.ReverseLayer =  [self addGraidLayerWithView:self CloskWise:false];
    
}

-(void)setupContrails{
    
    [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
}

#pragma mark - action
-(void)imgBtnClick:(UIButton*)sender{
    
    //已经连接的状态
    if (self.statusConnet) {
        [self reset];
        return;
    }
    
    //正在计时
    if (self.timer) {
        
        [self reset];
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.02 repeats:true block:^(NSTimer * _Nonnull timer) {
      
           if (weakSelf.progress < 1) {
               
               weakSelf.progress += 0.01;
               
               weakSelf.ForwardLayer.strokeEnd = weakSelf.progress;
               weakSelf.ReverseLayer.strokeEnd = weakSelf.progress;
               
           }else{
               
               [timer invalidate];
               weakSelf.timer = nil;
               weakSelf.statusConnet = true;
               
           }
           
       }];
    
    
}


//重置连接的状态
-(void)reset{
    
        self.ForwardLayer.strokeEnd = 0;
        [self.ForwardLayer removeAllAnimations];
        self.ReverseLayer.strokeEnd = 0;
        [self.ReverseLayer removeAllAnimations];
        self.progress = 0;
        self.statusConnet = false;
    
}

-(void)setStatusConnet:(BOOL)statusConnet{
    _statusConnet = statusConnet;
    
    if (statusConnet) {
        [_imageBtn setImage:[UIImage imageNamed:@"img_home_connet"] forState:UIControlStateNormal];
    }else{
        [_imageBtn setImage:[UIImage imageNamed:@"img_home_disconnet"] forState:UIControlStateNormal];
    }
    
}

#pragma mark - Helper

-(CAShapeLayer*)addGraidLayerWithView:(UIView*)view CloskWise:(BOOL)clockWise{
    
    CAShapeLayer* layer = [[CAShapeLayer alloc] init];
    layer.frame = view.bounds;
    layer.strokeColor = [UIColor colorWithHexString:@"58505E"].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 5;
    CGFloat radius = 88;
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:radius startAngle:M_PI_2 endAngle:M_PI_2 * 3 clockwise:clockWise];
    layer.path = path.CGPath;
    layer.strokeEnd = 0.0f;
    //设置渐变颜色
    CAGradientLayer* gradLayer = [[CAGradientLayer alloc] init];
    gradLayer.frame = view.bounds;
    [gradLayer setColors:@[(id)[UIColor colorWithHexString:@"5D00DF"].CGColor,(id)[UIColor colorWithHexString:@"780BE9"].CGColor,(id)[UIColor colorWithHexString:@"982DF3"].CGColor]];
    gradLayer.startPoint = CGPointMake(0.5, 1);
    gradLayer.endPoint = CGPointMake(0.5, 0);
    
    [gradLayer setMask:layer];
    [view.layer addSublayer:gradLayer];
    
    return layer;
    
}

#pragma mark - lazy

-(UIButton *)imageBtn{
    if (_imageBtn == nil) {
        _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imageBtn setImage:[UIImage imageNamed:@"img_home_disconnet"] forState:UIControlStateNormal];
        [_imageBtn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageBtn;
}



@end
