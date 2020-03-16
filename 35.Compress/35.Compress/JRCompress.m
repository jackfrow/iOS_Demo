//
//  JRCompress.m
//  35.Compress
//
//  Created by jackfrow on 2020/3/4.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "JRCompress.h"
#import "compression.h"

@implementation JRCompress

+(void)Compress{
    
    
    NSData *src = [NSData dataWithContentsOfFile:@"/Users/jackfrow/Desktop/testingMessage.txt"];
     
    NSLog(@"src: %ld",src.length);
     
    uint8_t *dstBuffer = (uint8_t *)malloc(src.length);
    memset(dstBuffer, 0, src.length);
     
    size_t compressResultLength = compression_encode_buffer(dstBuffer, src.length, [src bytes], src.length, NULL, COMPRESSION_LZMA);
     
    if (compressResultLength > 0) {
        NSData *newData = [NSData dataWithBytes:dstBuffer length:compressResultLength];
        [newData writeToFile:@"/Users/jackfrow/Desktop/testingMessage.data" atomically:YES];
        NSLog(@"com: %ld",compressResultLength);
        NSLog(@"com: %.2f",(src.length-compressResultLength)/(float)src.length);
         
    }else{
        NSLog(@"compress error!");
    }
     
    free(dstBuffer);
    
}

@end
