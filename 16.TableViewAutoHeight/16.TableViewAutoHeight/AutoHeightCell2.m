//
//  AutoHeightCell2.m
//  16.TableViewAutoHeight
//
//  Created by yy on 2019/8/19.
//  Copyright © 2019 xufanghao. All rights reserved.
//

#import "AutoHeightCell2.h"

@interface AutoHeightCell2 ()

@property (weak, nonatomic) IBOutlet UILabel *ContentLabel;

@end

@implementation AutoHeightCell2


-(void)setContentTitle:(NSString*)title{
    
    self.ContentLabel.text = title;
    
}

@end
