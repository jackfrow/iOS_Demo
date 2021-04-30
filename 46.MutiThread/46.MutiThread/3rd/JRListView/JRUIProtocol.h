//
//  JRUIProtocol.h
//  JRListView
//
//  Created by jackfrow on 2020/2/4.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JRUIProtocol <NSObject>

//默认高度为40,其余需要自己设置
+ (CGFloat)cellHeightWithModel:(JRBaseModel *)model contentWidth:(CGFloat)contentWidth;

-(void)addContent;

-(void)addContrails;


@end

NS_ASSUME_NONNULL_END
