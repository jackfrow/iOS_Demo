//
//  HashTable.h
//  20.HashTable
//
//  Created by yy on 2019/9/3.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HashTable<KeyType, ObjectType> : NSObject

//当前存储的个数
@property (nonatomic, assign,readonly) NSUInteger count;

//初始化hash表
- (instancetype)initWithCapacity:(NSUInteger)numItems;
//添加一个元素
-(void)appendObject:(id)anObject forKey:(NSString*)akey;
//移除一个元素
-(void)removeObjectForKey:(NSString*)akey;
//查询一个元素
-(nullable id)loopUpForKey:(NSString*)aKey;

@end


NS_ASSUME_NONNULL_END
