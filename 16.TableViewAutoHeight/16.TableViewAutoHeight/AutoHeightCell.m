//
//  AutoHeightCell.m
//  16.TableViewAutoHeight
//
//  Created by yy on 2019/8/19.
//  Copyright © 2019 xufanghao. All rights reserved.
//

#import "AutoHeightCell.h"

@interface AutoHeightCell ()

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *ContentLabel;

@end

@implementation AutoHeightCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


-(void)setContentTitle:(NSString *)title{
    self.ContentLabel.text = title;
}

@end
