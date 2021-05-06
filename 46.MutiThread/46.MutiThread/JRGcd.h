//
//  JRGcd.h
//  46.MutiThread
//
//  Created by jackfrow on 2021/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JRGcd : NSObject

+(void)syncConcurrent;

+ (void)asyncConcurrent;

+(void)syncSerial;

+ (void)asyncSerial;

+(void)syncMain;

+ (void)asyncMain;

+(void)communication;

+ (void)barrier;

+ (void)after;

+ (void)once;

+(void)apply;

+ (void)groupNotify;

+(void)groupWait;

+ (void)groupEnterAndLeave;

+ (void)semaphoreSync;

@end

NS_ASSUME_NONNULL_END
