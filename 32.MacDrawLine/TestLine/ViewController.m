//
//  ViewController.m
//  TestLine
//
//  Created by jackfrow on 2020/2/17.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ConnectWaveLayer.h"

@interface ViewController ()

@property (nonatomic, strong) ConnectWaveLayer *maskLayer;
@property (nonatomic, strong) CAShapeLayer *connectMaskLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.wantsLayer = true;
  
//    [self addLine];
//    [self setMask];
    
//    [self.maskLayer startWaterWave];
    [self shape];
}


-(void)shape{
    
    [self.view.layer addSublayer:self.connectMaskLayer];
}

-(void)setMask{
    
    
    CAGradientLayer* gradLayer = [[CAGradientLayer alloc] init];
    gradLayer.frame = CGRectMake(100, 100, 300, 300);
    [gradLayer setColors:@[
        (id)[NSColor whiteColor].CGColor,
        (id)[NSColor redColor].CGColor,
        (id)[NSColor blueColor].CGColor]];
    
    gradLayer.startPoint = CGPointMake(0.5, 0);
    gradLayer.endPoint = CGPointMake(0.5, 1);
        
    gradLayer.mask = self.maskLayer;
    
//    CATextLayer* text = [[CATextLayer alloc] init];
//    text.frame = CGRectMake(0, 0, 300 , 200);
//    text.string = @"TEST COLOR";
//    gradLayer.mask = text;
    
    [self.view.layer addSublayer:gradLayer];
    
}



-(void)addLine{
    
    self.view.wantsLayer = true;
    
    CAShapeLayer* shape = [CAShapeLayer layer];
    shape.bounds = CGRectMake(0, 0, 100, 100);
//    shape.fillColor = [NSColor redColor].CGColor;
//    shape.strokeColor = [NSColor redColor].CGColor;
//    NSBezierPath* path = [NSBezierPath bezierPath];
//    [path appendBezierPathWithArcWithCenter:CGPointMake(100, 100) radius:50 startAngle:0 endAngle:360];
//    [path setLineWidth:5];
//    shape.path = CGPathFromPath(path);
//    [self.view.layer addSublayer:shape];
    
    
    NSBezierPath* ber = [NSBezierPath bezierPath];
    [ber moveToPoint:NSMakePoint(100, 100)];
    [ber lineToPoint:NSMakePoint(200, 200)];
    [ber moveToPoint:NSMakePoint(200, 200)];
    [ber lineToPoint:NSMakePoint(200, 100)];
    [ber moveToPoint:NSMakePoint(200, 100)];
    [ber lineToPoint:NSMakePoint(300 ,300)];
    
//    [ber relativeLineToPoint:NSMakePoint(200, 200)];
//    [ber relativeLineToPoint:NSMakePoint(200,100 )];
    shape.path = CGPathFromPath(ber);
    [self.view.layer addSublayer:shape];

    
}

- (ConnectWaveLayer *)maskLayer {
    if (!_maskLayer) {
    
        _maskLayer = [ConnectWaveLayer layer];
        _maskLayer.frame = CGRectMake(0, 0, 200, 200);
        _maskLayer.progress = 0.0f;
//        __weak typeof(self) weakSelf = self;
        _maskLayer.ProgressBlock = ^(CGFloat currentLayerProgress) {
          
        };
        [_maskLayer setNeedsDisplay];
    }
    return _maskLayer;
}



- (CAShapeLayer *)connectMaskLayer {
    if (!_connectMaskLayer) {
        CAShapeLayer *masklayer = [CAShapeLayer layer];
        masklayer.frame = CGRectMake(0, 0, 200, 200);

        NSBezierPath* path = [NSBezierPath bezierPath];
              [path appendBezierPathWithArcWithCenter:CGPointMake(100, 100) radius:90 startAngle:0 endAngle:360];
        
        NSBezierPath* combinedShapePath = [NSBezierPath bezierPath];
        [combinedShapePath moveToPoint: CGPointMake(106.32, 86.19)];
        [combinedShapePath curveToPoint: CGPointMake(115, 99.9) controlPoint1: CGPointMake(111.44, 88.6) controlPoint2: CGPointMake(115, 93.83)];
        
        [combinedShapePath curveToPoint: CGPointMake(100, 115) controlPoint1: CGPointMake(115, 108.24) controlPoint2: CGPointMake(108.28, 115)];
        [combinedShapePath curveToPoint: CGPointMake(85, 99.9) controlPoint1: CGPointMake(91.72, 115) controlPoint2: CGPointMake(85, 108.24)];
        [combinedShapePath curveToPoint: CGPointMake(93.68, 86.19) controlPoint1: CGPointMake(85, 93.83) controlPoint2: CGPointMake(88.56, 88.6)];
        [combinedShapePath lineToPoint: CGPointMake(93.68, 89.81)];
        [combinedShapePath curveToPoint: CGPointMake(88.16, 99.9) controlPoint1: CGPointMake(90.36, 91.92) controlPoint2: CGPointMake(88.16, 95.65)];
        [combinedShapePath curveToPoint: CGPointMake(100, 111.82) controlPoint1: CGPointMake(88.16, 106.48) controlPoint2: CGPointMake(93.46, 111.82)];
        [combinedShapePath curveToPoint: CGPointMake(111.84, 99.9) controlPoint1: CGPointMake(106.54, 111.82) controlPoint2: CGPointMake(111.84, 106.48)];
        [combinedShapePath curveToPoint: CGPointMake(106.32, 89.81) controlPoint1: CGPointMake(111.84, 95.65) controlPoint2: CGPointMake(109.64, 91.92)];
        [combinedShapePath lineToPoint: CGPointMake(106.32, 86.19)];
        [combinedShapePath closePath];
        [combinedShapePath moveToPoint: CGPointMake(101.58, 85)];
        [combinedShapePath lineToPoint: CGPointMake(101.58, 99.49)];
        [combinedShapePath lineToPoint: CGPointMake(98.42, 99.49)];
        [combinedShapePath lineToPoint: CGPointMake(98.42, 85)];
        [combinedShapePath lineToPoint: CGPointMake(101.58, 85)];
        [combinedShapePath closePath];
        
        [path appendBezierPath:combinedShapePath];
        
        masklayer.path = CGPathFromPath(path);
        masklayer.fillColor = NSColor.redColor.CGColor;
        [masklayer setFillRule:kCAFillRuleEvenOdd];
        _connectMaskLayer = masklayer;
    }
    return _connectMaskLayer;
}




CGMutablePathRef CGPathFromPath(NSBezierPath* path){
    
        CGMutablePathRef cgPath = CGPathCreateMutable();
        NSInteger n = [path elementCount];
    
        for (NSInteger i = 0; i < n; i++) {
            NSPoint ps[3];
            switch ([path elementAtIndex:i associatedPoints:ps]) {
                case NSMoveToBezierPathElement: {
                    CGPathMoveToPoint(cgPath, NULL, ps[0].x, ps[0].y);
                    break;
                }
                case NSLineToBezierPathElement: {
                    CGPathAddLineToPoint(cgPath, NULL, ps[0].x, ps[0].y);
                    break;
                }
                case NSCurveToBezierPathElement: {
                    CGPathAddCurveToPoint(cgPath, NULL, ps[0].x, ps[0].y, ps[1].x, ps[1].y, ps[2].x, ps[2].y);
                    break;
                }
                case NSClosePathBezierPathElement: {
                    CGPathCloseSubpath(cgPath);
                    break;
                }
                default: NSLog(0, @"Invalid NSBezierPathElement");
            }
        }
    
    return cgPath;
    
}


@end
