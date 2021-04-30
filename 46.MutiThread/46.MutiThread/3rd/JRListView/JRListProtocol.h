//
//  JRListProtocol.h
//  JRListView
//
//  Created by jackfrow on 2020/2/3.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRBaseModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol JRListProtocol <NSObject>

@property (nonatomic, strong) JRBaseModel *model;

@end

NS_ASSUME_NONNULL_END
