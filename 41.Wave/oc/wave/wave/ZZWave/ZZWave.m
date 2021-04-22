//
//  ZZWave.m
//  wave
//
//  Created by jackfrow on 2021/4/21.
//

#import "ZZWave.h"

@interface ZZWave ()

@property (nonatomic, strong) UILabel *topTextLabel;

@property (nonatomic, strong) UILabel *bottomTextLabel;

@property (nonatomic, strong) CAShapeLayer *waveLayer;

@property (nonatomic, strong) CAShapeLayer *bottomTextLayer;

@property (nonatomic, strong) CAShapeLayer *topTextLayer;

@property (nonatomic, strong) CADisplayLink* timer;





@end



@implementation ZZWave



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self customUI];
    }
    return self;
}


-(void)customUI{
    self.text = @"RD";
    self.waveSpeed = 2;
    self.waveHeight = 12;
    [self.layer addSublayer:self.waveLayer];
    [self.layer addSublayer:self.topTextLayer];
    [self.layer addSublayer:self.bottomTextLayer];

}

#pragma mark - setter

-(void)setColor:(UIColor *)color{
    _color = color;
    
    self.topTextLayer.fillColor = [color CGColor];
    self.waveLayer.fillColor = [color CGColor];
}

#pragma mark - lazy


-(UILabel *)topTextLabel{
    if (_topTextLabel == nil) {
        _topTextLabel = [self createLabel];
        
    }
    return _topTextLabel;
}

-(UILabel *)bottomTextLabel{
    if (_bottomTextLabel == nil) {
        _bottomTextLabel = [self createLabel];
    }
    return _bottomTextLabel;;
}



-(CAShapeLayer *)waveLayer{
    if (_waveLayer == nil) {
        _waveLayer = [[CAShapeLayer alloc] init];
        _waveLayer.frame = self.bounds;
        _waveLayer.fillColor = self.color.CGColor;
         
    }
    return _waveLayer;
}

-(CAShapeLayer *)bottomTextLayer{
    if (_bottomTextLayer == nil) {
        _bottomTextLayer = [[CAShapeLayer alloc] init];
        _bottomTextLayer.frame = self.bounds;
        _bottomTextLayer.fillColor = [UIColor whiteColor].CGColor;
        _bottomTextLayer.mask = self.bottomTextLabel.layer;
    }
    return _bottomTextLayer;
}


-(CAShapeLayer *)topTextLayer{
    if (_topTextLayer == nil) {
        _topTextLayer = [[CAShapeLayer alloc] init];
        _topTextLayer.frame = self.bounds;
        _topTextLayer.fillColor = [UIColor whiteColor].CGColor;
        _topTextLayer.mask = self.topTextLabel.layer;
    }
    return _topTextLayer;
}

-(CADisplayLink *)timer{
    if (_timer == nil) {
        //todo 这里有内存泄漏，稍等来处理。
        _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(animation)];
    }
    return _timer;
}


-(void)animation{
    
    //t表示每一个长度的度数是多少
    CGFloat width = self.bounds.size.width;
    CGFloat t     = M_PI * 2 / self.bounds.size.width;
    
    self.waveOffset += self.waveSpeed;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGMutablePathRef turnPath = CGPathCreateMutable();
    

    
    CGFloat startOffsetY = self.waveHeight * sinf(self.waveOffset*t)+self.bounds.size.height / 2.0;
    
    CGPathMoveToPoint(path, nil, 0, startOffsetY);
    CGPathMoveToPoint(turnPath, NULL, 0, startOffsetY);

    
    for (int x = 0 ; x< self.bounds.size.width; x++) {
        CGFloat offsetY = sinf(self.waveOffset*t + x * t) * self.waveHeight+self.bounds.size.height / 2.0;
        CGPathAddLineToPoint(path, nil, x, offsetY);
        CGPathAddLineToPoint(turnPath, NULL, x, offsetY);
    }
    
    // 闭合path
    CGPathAddLineToPoint(path, NULL, width, self.bounds.size.height);
    CGPathAddLineToPoint(path, NULL, 0, self.bounds.size.height);
    CGPathAddLineToPoint(path, NULL, 0, startOffsetY);
    CGPathCloseSubpath(path);
    
    //闭合turnPath
    CGPathAddLineToPoint(turnPath, NULL, width, 0);
    CGPathAddLineToPoint(turnPath, NULL, 0, 0);
    CGPathAddLineToPoint(turnPath, NULL, 0, startOffsetY);
    CGPathCloseSubpath(turnPath);

    self.waveLayer.path = path;
    self.bottomTextLayer.path = path;
    self.topTextLayer.path = turnPath;
    
    CGPathRelease(path);
}


#pragma mark - API

-(void)startAnimation{
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}


#pragma mark - help

-(UILabel* )createLabel {
    UILabel* label  = [[UILabel alloc] initWithFrame:self.bounds];
    label.font = [UIFont systemFontOfSize:100 weight:UIFontWeightBold];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.text;
    return label;
}



@end
