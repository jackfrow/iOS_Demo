//
//  JRPickerModel.h
//  10-JRPickerDemo
//
//  Created by jackfrow on 2019/4/16.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JRPickerModel : NSObject

@property (nonatomic,copy) NSString *title;

@property (nonatomic,strong) NSMutableArray<JRPickerModel*> * subModels ;

@property (nonatomic,strong) id  obj ;//携带的数据

+(JRPickerModel*)itemWithTitle:(NSString*)title;

+(JRPickerModel*)itemWithTitle:(NSString*)title
                           obj:(nullable id)obj;

+(JRPickerModel *)itemWithTitle:(NSString *)title
                            obj:(nullable id)obj
                      subModels:(NSArray<JRPickerModel*> *)subModels;

@end

NS_ASSUME_NONNULL_END
