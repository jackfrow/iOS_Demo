//
    


#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConnectWaveLayer : CAShapeLayer
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, copy) void(^ProgressBlock)(CGFloat currentLayerProgress);
@property (nonatomic, assign) CGFloat WaveY; // ver offset
@property (nonatomic, assign) CGFloat WaveX; //hor offset
@property (nonatomic, strong) NSTimer *link; // wave water
- (void)stopWaterWave;
- (void)startWaterWave;
@end

NS_ASSUME_NONNULL_END
