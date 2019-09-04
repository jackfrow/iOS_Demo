//
//  HashTable.m
//  20.HashTable
//
//  Created by yy on 2019/9/3.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

#import "HashTable.h"

//最大容量2^30
#define MAX_CAPACITY pow(2, 30)

@interface HashNode : NSObject

//key
@property (nonatomic, copy) NSString* key;
//value
@property (nonatomic, strong) id value;
//下一个节点
@property (nonatomic, strong) HashNode *next;

- (instancetype)initWithKey:(NSString *)key value:(id)value;

@end

@interface HashTable ()

//默认字典长度(默认给16的长度)
@property (nonatomic, assign) NSUInteger defaultLength;
//默认最大负载因子(默认为0.75)
@property (nonatomic, assign) double defaultLoader;
//当前存储的个数
@property (nonatomic, assign) NSUInteger countSize;
//真正存储数据的数组
@property (nonatomic, strong) NSMutableArray *elementArray;

@end

@implementation HashTable

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInitWithCapacity:16];
    }
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems{
    
    if (self = [super init]) {
        [self commonInitWithCapacity:numItems];
    }
    return self;
    
}

-(void)commonInitWithCapacity:(NSUInteger)numItems{
           _defaultLength = numItems;
           _defaultLoader = 0.75;
           _countSize = 0;
           _elementArray = [NSMutableArray arrayWithCapacity:numItems];
    for (int i = 0; i < numItems; i++) {
        [_elementArray addObject:@"1"];
    }
}


#pragma mark - Method
-(void)appendObject:(id)anObject forKey:(NSString*)akey{
    //1.判断是否需要扩容(因为如果超过了负载因子,很容易出现重复)
    if ((self.countSize / self.defaultLength) > self.defaultLoader) {
        _defaultLength *= 2;
        [self resizeOfNewCapacity:_defaultLength];
    }
    //2.获取index
    NSUInteger index = [self findIndex:akey];
    //3.如果插入区域是空的,则直接将数据插入
    HashNode* node = [self.elementArray objectAtIndex:index];
    HashNode* newNode = [[HashNode alloc] initWithKey:akey value:anObject];
    if (![[node class] isEqual:[HashNode class]]) {
        [_elementArray replaceObjectAtIndex:index withObject:newNode];
        _countSize += 1;
    }else{
         //4.如果插入区域非空,则采用拉链法解决冲突
        HashNode* pre = [[HashNode alloc] init];
        pre.next = node;
        while (node != NULL) {
            //如果插入了相同的key,则覆盖原来的值
            if ([node.key isEqualToString:newNode.key]) {
                node.value = newNode.value;
                return;
            }
            node = node.next;
        }
        newNode.next = pre.next;
        [_elementArray replaceObjectAtIndex:index withObject:newNode];
        _countSize += 1;
    }
    
}

-(nullable id)loopUpForKey:(NSString *)aKey{
    //1.获取index
    NSUInteger index = [self findIndex:aKey];
    //2.查找
      HashNode* node = [self.elementArray objectAtIndex:index];
    if (![[node class] isEqual:[HashNode class]]) {
        return nil;
    }else{
        //遍历链表,直到找到相同的key
        while (node != NULL) {
            if ([node.key isEqualToString:aKey]) {
                return node.value;
            }
            node = node.next;
        }
        return  nil;
    }
    
}

-(void)removeObjectForKey:(NSString *)akey{
    //1.获取index
    NSUInteger index = [self findIndex:akey];
    //2.查找
    HashNode* node = [self.elementArray objectAtIndex:index];
    if ([node isEqual:[HashNode class]]) {
        HashNode* pre = [[HashNode alloc] init];
        pre.next = node;
        BOOL firstNode = true;
        
        while (node != NULL) {
            if ([node.key isEqualToString:akey]) {
                if (firstNode) {//如果是第一个节点,则替换
                    HashNode* next = node.next;
                    [self.elementArray replaceObjectAtIndex:index withObject:next];
                    return;
                }else{
                    pre.next = node.next;
                    return;
                }
              
            }
              pre.next = node;
              node = node.next;
              firstNode = false;
        }
    }
    
}

-(NSUInteger)count{
    return self.countSize;
}

#pragma mark - Private Method
- (void)resizeOfNewCapacity:(NSInteger)newCapacity {
    NSInteger oldCapacity = _elementArray.count;
    if (oldCapacity == MAX_CAPACITY) {         // 扩容前的数组大小如果已经达到最大2^30
        return;
    }
    //1.初始化一个新数组
    NSMutableArray* newArray = [NSMutableArray arrayWithCapacity:newCapacity];
    for (int i = 0; i < newCapacity; i ++) {
           [newArray addObject:@""];
       }
    //2.将数据转移到新数组中
    [self transferWithNewTable:newArray];
    [_elementArray removeAllObjects];
    [_elementArray addObjectsFromArray:newArray];
}

- (void)transferWithNewTable:(NSMutableArray *)array{
    // 遍历旧数组，将元素转移到新数组中
    for (HashNode* __strong node in _elementArray) {
        if ([node isEqual:[HashNode class]]) {
            while (node != NULL) {
                [self insertElementToArrayWith:array andNode:node];
                node = node.next;
            }
        }
    }
}

- (void)insertElementToArrayWith:(NSMutableArray *)array andNode:(HashNode *)node{
    
    NSUInteger index = [self findIndex:node.key];
    if (![[array objectAtIndex:index] isEqual:[HashNode class]]) {
        [array replaceObjectAtIndex:index withObject:node];
    }else{
        HashNode* headNode = [array objectAtIndex:index];
        node.next = headNode;
        [array replaceObjectAtIndex:index withObject:node];
        
    }
    
}

//获取当前对象的index
-(NSUInteger)findIndex:(NSString*)aKey{
    NSUInteger index = aKey.hash;
    return index % _defaultLength;
}

@end

@implementation HashNode

- (instancetype)initWithKey:(NSString *)key value:(id)value{
    if (self = [super init]) {
        _key = key;
        _value = value;
    }
    return self;
}

@end
