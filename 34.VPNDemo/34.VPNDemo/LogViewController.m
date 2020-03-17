//
//  LogViewController.m
//  34.VPNDemo
//
//  Created by jackfrow on 2020/3/4.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "LogViewController.h"
#import "PotatsoBase.h"


@interface LogViewController ()

@property (nonatomic, strong) UITextView *logView;
@property (nonatomic, strong) dispatch_source_t readeSource;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, assign) int fd;

@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self.view addSubview:self.logView];
    [self showLog];
    
}


#pragma mark - Util
-(void)showLog{
    
    NSLog(@"sharedLogUrl == %@",[Potatso sharedLogUrl]);
    
    self.fd = open([Potatso sharedLogUrl].path.UTF8String, O_RDONLY);
    if (self.fd <= 0) {
        return;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_source_t readSource =  dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, self.fd, 0, queue);
    self.readeSource = readSource;
    
    
    if (!readSource) {
        close(self.fd);
        return;
    }
    
    
    dispatch_source_set_event_handler(readSource, ^{
        [self updateUI];
    });
    
    dispatch_source_set_cancel_handler(readSource, ^{
        close(self.fd);
    });
    
    dispatch_resume(readSource);

}

-(void)updateUI{
    
     size_t estimatedSize = dispatch_source_get_data(self.readeSource) + 1;
      char *buffer = (char *)malloc(estimatedSize);
    
          if (buffer) {
                ssize_t actual = read(self.fd, buffer, (estimatedSize));
                // do something with buffer
              [self.data appendBytes:buffer length:actual];
              
            NSString* content =   [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
              NSLog(@"conent = %@",content);
              
              if (content) {
                  dispatch_async(dispatch_get_main_queue(), ^{

                      self.logView.text = [NSString stringWithFormat:@"%@%@",self.logView.text,content];

                  });
                  
                  
                  self.data = [[NSMutableData alloc] init];
              }
              
                free(buffer);
                
                //读取完毕后
    //            dispatch_source_cancel(readSource);
            }
    
    
}

#pragma mark - lazy
-(UITextView *)logView{
    if (_logView == nil) {
        _logView = [[UITextView alloc] init];
        _logView.editable = false;
        _logView.backgroundColor = [UIColor whiteColor];
        _logView.text = @"testing";
        _logView.frame = self.view.bounds;
    }
    return _logView;
}

-(NSMutableData *)data{
    if (_data == nil) {
        _data = [[NSMutableData alloc] init];
    }
    return _data;
}


@end
