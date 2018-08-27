//
//  NSLockDemo.h
//  01-ThreadLock
//
//  Created by jackfrow on 2018/8/21.
//  Copyright © 2018年 jackfrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LockProtocol.h"

@interface NSBasicLock : NSObject <LockProtocol>

@end

@interface NSLockDemo : NSBasicLock

@end


@interface NSConditionLockDemo : NSBasicLock 

@end
//NSRecursiveLock

@interface NSRecursiveLockDemo : NSBasicLock

@end

@interface NSConditionDemo : NSBasicLock

@end

@interface NSSynchronizedDemo : NSBasicLock

@end

@interface NSsemaphoreDemo : NSBasicLock

@end

@interface NSOSSpinLockDemo : NSBasicLock

@end

@interface NSPrethreadDemo : NSBasicLock

@end

