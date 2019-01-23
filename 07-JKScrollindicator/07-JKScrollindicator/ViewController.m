//
//  ViewController.m
//  07-JKScrollindicator
//
//  Created by jackfrow on 2019/1/23.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "JKScrollindicator/JKScrollindicator.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView * scrollView ;
@property (nonatomic,strong) JKScrollindicator * scrollIndicator ;//滚动条
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.scrollIndicator];
    
}

-(UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 100)];
        _scrollView.backgroundColor = UIColor.redColor;
//        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView setContentSize:CGSizeMake(2000, 0)];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(JKScrollindicator *)scrollIndicator{
    
    if (_scrollIndicator == nil) {
        _scrollIndicator = [[JKScrollindicator alloc] initWithFrame:CGRectMake(100, 400, 80, 4)];
    }
    return _scrollIndicator;
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat totalScrollRange = scrollView.contentSize.width - scrollView.bounds.size.width;
    CGFloat progress = scrollView.contentOffset.x / totalScrollRange;
    self.scrollIndicator.progress = progress;
}

@end
