//
//  JRPickerModel.m
//  10-JRPickerDemo
//
//  Created by jackfrow on 2019/4/16.
//  Copyright © 2019 jackfrow. All rights reserved.
//

#import "JRPickerModel.h"

@implementation JRPickerModel

+(JRPickerModel *)itemWithTitle:(NSString *)title{
    return [self itemWithTitle:title obj:nil];
}

+(JRPickerModel *)itemWithTitle:(NSString *)title obj:(id)obj{
    
    JRPickerModel* model = [[JRPickerModel alloc] init];
    model.title = title;
    model.obj = obj;
    return model;
}

+(JRPickerModel *)itemWithTitle:(NSString *)title obj:(id)obj subModels:(NSArray<JRPickerModel *> *)subModels{
    
    JRPickerModel* model = [[JRPickerModel alloc] init];
    model.title = title;
    model.obj = obj;
    [model.subModels addObjectsFromArray:subModels];
    return model;
}

-(NSMutableArray<JRPickerModel *> *)subModels{
    if (_subModels == nil) {
        _subModels = [[NSMutableArray alloc] init];
    }
    return _subModels;
}


@end
