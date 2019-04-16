//
//  JRPickerView.h
//  10-JRPickerDemo
//
//  Created by jackfrow on 2019/4/16.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JRPickerModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^JRPickerHandle)(NSArray<JRPickerModel*>* models);

@interface JRPickerView : UIView

//回调
@property (nonatomic,copy) JRPickerHandle handler;

+(void)showWithSelectHandler:(JRPickerHandle)handler  dateSource:(NSArray<JRPickerModel*>*)dataSource numberOfComponents:(NSInteger)numberOfComponents;

+(void)showWithSelectHandler:(JRPickerHandle)handler title:(NSString *)title dateSource:(NSArray<JRPickerModel*>*)dataSource numberOfComponents:(NSInteger)numberOfComponents;

@end

NS_ASSUME_NONNULL_END
