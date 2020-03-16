//
//  JRLocalCacheDirectory.m
//  36.AutoUpdate
//
//  Created by jackfrow on 2020/3/6.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "JRLocalCacheDirectory.h"


static NSTimeInterval OLD_ITEM_DELETION_INTERVAL = 86400 * 10; // 10 days


@implementation JRLocalCacheDirectory

+ (NSString *)cachePathForBundleIdentifier:(NSString *)bundleIdentifier{
    
      NSURL *cacheURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:NULL];
        assert(cacheURL != nil);
        NSString *resultPath = [[cacheURL URLByAppendingPathComponent:bundleIdentifier] path];
        assert(resultPath != nil);
        
        return resultPath;
}

+ (void)removeOldItemsInDirectory:(NSString *)directory{
    
    NSMutableArray<NSString *> *filePathsToRemove = [NSMutableArray array];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:directory]) {
        
        NSDirectoryEnumerator *directoryEnumerator = [fileManager enumeratorAtPath:directory];
        NSDate *currentDate = [NSDate date];
        
        for (NSString* filename in directoryEnumerator) {
            
               NSDictionary<NSString *, id> *fileAttributes = [fileManager attributesOfItemAtPath:[directory stringByAppendingPathComponent:filename] error:NULL];
            
            if (fileAttributes != nil)
                  {
                      NSDate *lastModificationDate = [fileAttributes objectForKey:NSFileModificationDate];
                      if ([currentDate timeIntervalSinceDate:lastModificationDate] >= OLD_ITEM_DELETION_INTERVAL)
                      {
                          [filePathsToRemove addObject:[directory stringByAppendingPathComponent:filename]];
                      }
                  }
            
            [directoryEnumerator skipDescendants];
        }
        
        for (NSString *filename in filePathsToRemove)
         {
             [fileManager removeItemAtPath:filename error:NULL];
         }
        
    }
    
}

+ (NSString * _Nullable)createUniqueDirectoryInDirectory:(NSString *)directory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *createError = nil;
    if (![fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&createError]) {
        NSLog(@"Failed to create directory with intermediate components at %@ with error %@",directory,createError);
        return nil;
    }
    
    NSString *templateString = [directory stringByAppendingPathComponent:@"XXXXXXXXX"];
    char buffer[PATH_MAX] = {0};
    if ([templateString getFileSystemRepresentation:buffer maxLength:sizeof(buffer)]) {
        if (mkdtemp(buffer) != NULL) {
            return [[NSString alloc] initWithUTF8String:buffer];
        }
    }
    return nil;
}

@end
