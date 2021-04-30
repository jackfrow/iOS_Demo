//
//  JRBaseCell.m
//  JRListView
//
//  Created by jackfrow on 2020/2/4.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "JRBaseCell.h"

@implementation JRBaseCell
@synthesize model = _model;



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addContent];
        [self addContrails];
    }
    return self;
}

+(CGFloat)cellHeightWithModel:(JRBaseModel *)model contentWidth:(CGFloat)contentWidth{
    return 40;
}


#pragma mark - API
-(void)addContent{
    //子类实现
}

-(void)addContrails{
    //子类实现
}

@end
