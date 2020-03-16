//
//  JRUpdateDownload.m
//  36.AutoUpdate
//
//  Created by jackfrow on 2020/3/5.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "JRUpdateDownload.h"
#import "JRLocalCacheDirectory.h"
#import "JRApplication.h"

@interface JRUpdateDownload ()<NSURLSessionDownloadDelegate>

@property (nonatomic, weak) id<JRUpdateDownloadProtocol> delegate;
@property (nonatomic, strong) NSURLSession *downloadSession;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@end

@implementation JRUpdateDownload


- (instancetype)initWithDelegate:(id<JRUpdateDownloadProtocol>)delegate{
    
    if (self = [super init]) {
        _delegate = delegate;
    }
    return self;
    
}

-(void)startDownLoadWithUrlString:(NSString *)urlString{
    
    NSURL* url = [NSURL URLWithString:urlString];
    self.downloadTask =   [self.downloadSession downloadTaskWithURL:url];
    [self.downloadTask resume];
    
}


#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    NSLog(@"locationPath = %@",location.path);
    NSLog(@"didFinishDownloadingToURL");
    
    NSString* tempDir = [self getAndCleanTempDirectory];
    if (tempDir != nil) {
        
         NSString *downloadFileName = [NSString stringWithFormat:@"%@%@",[JRApplication appName],[JRApplication appVersion]];
        NSString* downloadFileNameDirectory = [tempDir stringByAppendingPathComponent:downloadFileName];
        
         NSError *createError = nil;
        if (![[NSFileManager defaultManager] createDirectoryAtPath:downloadFileNameDirectory withIntermediateDirectories:NO attributes:nil error:&createError]) {
            
            [self.delegate downloaderDidFailWithError:createError];
            
        }else{
            
            NSString* name = self.downloadTask.response.suggestedFilename;
            if (!name) {
                name = location.lastPathComponent;
            }
            NSString *toPath = [downloadFileNameDirectory stringByAppendingPathComponent:name];
             NSString *fromPath = location.path; // suppress moveItemAtPath: non-null
             NSError *error = nil;
            if ([[NSFileManager defaultManager] moveItemAtPath:fromPath toPath:toPath error:&error]) {
                
                [self.delegate downloadFinishWithDestinationName:toPath temporaryDirectory:downloadFileNameDirectory];
                
                
            }else{
                [self.delegate downloaderDidFailWithError:error];
            }
            
        }
        
        
    }
    

    
}


- (void)URLSession:(NSURLSession *)session
           downloadTask:(NSURLSessionDownloadTask *)downloadTask
           didWriteData:(int64_t)bytesWritten
           totalBytesWritten:(int64_t)totalBytesWritten
           totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    
    CGFloat progress =  1.0 * totalBytesWritten / totalBytesExpectedToWrite ;
    NSLog(@"downloadProgress = %f",progress);
    
    if ([self.delegate respondsToSelector:@selector(downLoadProgress:)]) {
        [self.delegate downLoadProgress:progress];
    }
     

}




- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error{

    NSLog(@"didCompleteWithError === %@",error);
    
    if (error) {
        [self.delegate downloaderDidFailWithError:error];
    }

}

-(NSURLSession *)downloadSession{
    
    if (_downloadSession == nil) {
        _downloadSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _downloadSession;
}



-(NSString*)getAndCleanTempDirectory
{
    NSString* rootPersistentDownloadCachePath = [[JRLocalCacheDirectory cachePathForBundleIdentifier:[JRApplication bundleIdentifier]] stringByAppendingPathComponent:@"PersistentDownloads"];
    
    [JRLocalCacheDirectory removeOldItemsInDirectory:rootPersistentDownloadCachePath];
    
    NSString*  tempDir = [JRLocalCacheDirectory createUniqueDirectoryInDirectory:rootPersistentDownloadCachePath];
    if (tempDir == nil) {
    
        // Okay, something's really broken with this user's file structure.
        NSError *error = [NSError errorWithDomain:@"ty" code:-1001 userInfo:@{ NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Can't make a temporary directory for the update download at %@.", tempDir] }];
        [self.delegate downloaderDidFailWithError:error];
        
    }
    
    return tempDir;
    
}

@end
