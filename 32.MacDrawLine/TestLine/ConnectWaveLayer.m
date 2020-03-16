//
    
#import <AppKit/AppKit.h>
#import "ConnectWaveLayer.h"
#define WaveHight 5 //amplitude

#define MinHeight (192 + 5) //current layer bottom

#define MaxHeight (8 - 5) // current wave layer top

#define ValueOffset (MinHeight-MaxHeight)

#define WaveAngularVel (M_PI / 100.0f)

@interface ConnectWaveLayer ()

@end
@implementation ConnectWaveLayer

- (instancetype)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    if (self) {
        if ([self isKindOfClass:ConnectWaveLayer.class]) {
            ConnectWaveLayer *circle = (ConnectWaveLayer *)layer;
            self.ProgressBlock = circle.ProgressBlock;
            self.progress = circle.progress;
            self.WaveX = circle.WaveX;
            self.WaveY = circle.WaveY;
            self.path = circle.path;
            self.fillColor = circle.fillColor;
            self.modelLayer.link = circle.link;
//            self.backgroundColor = [NSColor blackColor].CGColor;
        }
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx {
    self.WaveY = self.progress * ValueOffset + 3;
    [self updateWaveLayer:ctx];
    if (self.ProgressBlock) {
        NSLog(@"current progress :%.2f", self.progress);
        self.ProgressBlock(self.progress);
    }
}

- (void)waveUpdate {
    self.WaveX += WaveAngularVel * 1.5f;
    self.progress += 0.01;
    [self setNeedsDisplay];
}

- (void)updateWaveLayer:(CGContextRef)ctx {
    CGMutablePathRef path = CGPathCreateMutable();

    CGPathMoveToPoint(path, nil, 0, self.WaveY);
    CGFloat y = self.WaveY;
    for (float x = 0.0f; x <= self.bounds.size.width; x ++) {
        y = WaveHight * sin(WaveAngularVel * x + self.WaveX) + self.WaveY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, self.bounds.size.width, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    CGContextAddPath(ctx, path);
    CGContextSetFillColorWithColor(ctx, NSColor.whiteColor.CGColor);
    CGContextFillPath(ctx);
    CGPathRelease(path);
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"progress"]) {
        return true;
    }
    return [super needsDisplayForKey:key];
}

- (void)stopWaterWave {
    if (_link) {
        [_link invalidate];
        _link = nil;
    }
}

- (void)startWaterWave {
    if (!_link) {
        self.link =  [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(waveUpdate) userInfo:nil repeats:true];;
    }
}

- (void)dealloc {
    [self stopWaterWave];
}

@end
