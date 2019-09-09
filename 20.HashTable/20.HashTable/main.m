//
//  main.m
//  20.HashTable
//
//  Created by yy on 2019/9/3.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HashTable.h"

static int loopCount = 100000;

void testMyhash(){
 
    HashTable* table = [[HashTable alloc] init];

    
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    for (int i = 0 ; i < loopCount; i++) {
        
        NSString* key = [NSString stringWithFormat:@"%d",i];
        NSString* value = [NSString stringWithFormat:@"value = %d",i];
    
        [table appendObject:value forKey:key];
    }
    
    for (int i = 0 ; i < loopCount; i++) {
        NSString* key = [NSString stringWithFormat:@"%d",i];
        [table loopUpForKey:key];
//        NSLog(@"key = %@ ---- value = %@",key,[table loopUpForKey:key]);
    }
    
    CFAbsoluteTime endTime = (CFAbsoluteTimeGetCurrent() - startTime);

    NSLog(@"Myhash耗时: %f ms", endTime * 1000.0);
    
}

void testSystem(){
    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
       
       for (int i = 0 ; i < loopCount; i++) {
           
           NSString* key = [NSString stringWithFormat:@"%d",i];
           NSString* value = [NSString stringWithFormat:@"value = %d",i];
           [dic setObject:value forKey:key];
          
       }
       
       for (int i = 0 ; i < loopCount; i++) {
           NSString* key = [NSString stringWithFormat:@"%d",i];
           [dic objectForKey:key];
//           NSLog(@"key = %@ ---- value = %@",key,[dic objectForKey:key]);
       }
       
       CFAbsoluteTime endTime = (CFAbsoluteTimeGetCurrent() - startTime);

       NSLog(@"系统hash耗时: %f ms", endTime * 1000.0);
    
}

void testAppend(){
    HashTable* t = [[HashTable alloc] init];
    
    NSString* key = [NSString stringWithFormat:@"%d",1];
    
    //对于string,相同的值,引用的地址是相同的。
    
    [t appendObject:@"2" forKey:@"1"];
    [t appendObject:@"3" forKey:key];
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        //1.测试自己搭建的hash耗时
        testMyhash();
        //2.测试系统的
        testSystem();
        //3.测试hash
        //3.1系统默认的哈希实现为取该对象的地址(<HashTable: 0x100562a80>,hash = 4300614272)
//        HashTable* t = [[HashTable alloc] init];
//        NSLog(@"hash = %lu",(unsigned long)t.hash);
        
        
    }
    return 0;
}






