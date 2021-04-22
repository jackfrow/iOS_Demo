//
//  ViewController.m
//  wave
//
//  Created by jackfrow on 2021/4/21.
//

#import "ViewController.h"
#import "ZZWave.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"vmfvivhu = %.f",sinf(90));
    
    NSoperation
    

    ZZWave* wave = [[ZZWave alloc] initWithFrame:CGRectMake((([UIScreen mainScreen].bounds.size.width - 200) / 2.0), 200, 200, 200)];
    wave.color = [UIColor magentaColor];
    wave.layer.cornerRadius = 100;
    wave.layer.masksToBounds = true;
    wave.layer.borderColor = [UIColor lightGrayColor].CGColor;
    wave.layer.borderWidth = 0.5f;
    [self.view addSubview:wave];

    [wave startAnimation];
    

}


@end
