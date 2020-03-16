//
//  ViewController.m
//  31.CaShapeLayerDemo
//
//  Created by jackfrow on 2020/2/18.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CAShapeLayer *chooseServerMaskLayer;
@property (nonatomic, strong) CAShapeLayer *connectMaskLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self.view.layer addSublayer:self.chooseServerMaskLayer];
    [self.view.layer addSublayer:self.connectMaskLayer];
    
}

- (CAShapeLayer *)chooseServerMaskLayer {
    if (!_chooseServerMaskLayer) {
        CAShapeLayer *masklayer = [CAShapeLayer layer];
        masklayer.frame = CGRectMake(0, 0, 200, 200);
        
        CGFloat length = 40;
        CGFloat width = 200.0f;
        CGFloat height = 200.0f;
        CGFloat halfLength = length / 2.0;
        UIBezierPath * ber = [UIBezierPath bezierPath];
        [ber moveToPoint:CGPointMake(width / 2 - halfLength, height / 2 - 2)];
        [ber addLineToPoint:CGPointMake(width / 2 - 2, height / 2 - 2)];
        [ber addLineToPoint:CGPointMake(width / 2 - 2, height / 2 - halfLength)];
        [ber addLineToPoint:CGPointMake(width / 2 + 2, height / 2 - halfLength)];
        [ber addLineToPoint:CGPointMake(width / 2 + 2, height / 2 - 2)];
        [ber addLineToPoint:CGPointMake(width / 2 + halfLength, height / 2 - 2)];
        [ber addLineToPoint:CGPointMake(width / 2 + halfLength, height / 2 + 2)];
        [ber addLineToPoint:CGPointMake(width / 2 + 2, height / 2 + 2)];
        [ber addLineToPoint:CGPointMake(width / 2 + 2, height / 2 + halfLength)];
        [ber addLineToPoint:CGPointMake(width / 2 - 2, height / 2 + halfLength)];
        [ber addLineToPoint:CGPointMake(width / 2 - 2, height / 2 + 2)];
        [ber addLineToPoint:CGPointMake(width / 2 - halfLength, height / 2 + 2)];
        [ber addLineToPoint:CGPointMake(width / 2 - halfLength, height / 2 -2)];

        masklayer.path = ber.CGPath;
        _chooseServerMaskLayer = masklayer;
    }
    return _chooseServerMaskLayer;
}


- (CAShapeLayer *)connectMaskLayer {
    if (!_connectMaskLayer) {
        CAShapeLayer *masklayer = [CAShapeLayer layer];
        masklayer.frame = CGRectMake(0, 0, 200, 200);

        
        UIBezierPath* combinedShapePath = [UIBezierPath bezierPath];
        [combinedShapePath moveToPoint: CGPointMake(106.32, 86.19)];
        [combinedShapePath addCurveToPoint: CGPointMake(115, 99.9) controlPoint1: CGPointMake(111.44, 88.6) controlPoint2: CGPointMake(115, 93.83)];
        [combinedShapePath addCurveToPoint: CGPointMake(100, 115) controlPoint1: CGPointMake(115, 108.24) controlPoint2: CGPointMake(108.28, 115)];
        [combinedShapePath addCurveToPoint: CGPointMake(85, 99.9) controlPoint1: CGPointMake(91.72, 115) controlPoint2: CGPointMake(85, 108.24)];
        [combinedShapePath addCurveToPoint: CGPointMake(93.68, 86.19) controlPoint1: CGPointMake(85, 93.83) controlPoint2: CGPointMake(88.56, 88.6)];
        [combinedShapePath addLineToPoint: CGPointMake(93.68, 89.81)];
        [combinedShapePath addCurveToPoint: CGPointMake(88.16, 99.9) controlPoint1: CGPointMake(90.36, 91.92) controlPoint2: CGPointMake(88.16, 95.65)];
        [combinedShapePath addCurveToPoint: CGPointMake(100, 111.82) controlPoint1: CGPointMake(88.16, 106.48) controlPoint2: CGPointMake(93.46, 111.82)];
        [combinedShapePath addCurveToPoint: CGPointMake(111.84, 99.9) controlPoint1: CGPointMake(106.54, 111.82) controlPoint2: CGPointMake(111.84, 106.48)];
        [combinedShapePath addCurveToPoint: CGPointMake(106.32, 89.81) controlPoint1: CGPointMake(111.84, 95.65) controlPoint2: CGPointMake(109.64, 91.92)];
        [combinedShapePath addLineToPoint: CGPointMake(106.32, 86.19)];
        [combinedShapePath closePath];
        [combinedShapePath moveToPoint: CGPointMake(101.58, 85)];
        [combinedShapePath addLineToPoint: CGPointMake(101.58, 99.49)];
        [combinedShapePath addLineToPoint: CGPointMake(98.42, 99.49)];
        [combinedShapePath addLineToPoint: CGPointMake(98.42, 85)];
        [combinedShapePath addLineToPoint: CGPointMake(101.58, 85)];
        [combinedShapePath closePath];

        masklayer.path = combinedShapePath.CGPath;
        
        _connectMaskLayer = masklayer;
    }
    return _connectMaskLayer;
}





@end
