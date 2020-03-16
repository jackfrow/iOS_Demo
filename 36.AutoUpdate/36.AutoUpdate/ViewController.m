//
//  ViewController.m
//  36.AutoUpdate
//
//  Created by jackfrow on 2020/3/5.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "JRUpdateDownload.h"
#import "JRUpdateHelper.h"


static NSString* downloadLink = @"https://github.com/shadowsocks/ShadowsocksX-NG/releases/download/v1.9.4/ShadowsocksX-NG.1.9.4.zip";

@interface ViewController ()<JRUpdateDownloadProtocol>

@property (weak) IBOutlet NSProgressIndicator *progress;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progress.doubleValue = 0;

    
}

/**
重启自己
 */
- (void)restart {
    [self save];
    [self open];
//    exit(0);
}

/**
退出之前需要保存的数据
 */
- (void)save {

}

- (void)open {
    //获得本程序的路径
    NSString *applicationPath = [[NSBundle mainBundle] bundlePath];
    NSLog(@"applicationPath == %@",applicationPath);
    //创建任务
    NSTask *task = [[NSTask alloc] init];
    //启动路径
    task.launchPath = @"/usr/bin/open";
    //添加参数
    task.arguments = @[@"-n", applicationPath];
    //启动
    [task launch];
}

- (IBAction)downLoad:(id)sender {

    [self restart];

//      JRUpdateDownload* download = [[JRUpdateDownload alloc] initWithDelegate:self];
//      [download startDownLoadWithUrlString:downloadLink];
    
//      [download startDownLoadWithUrlString:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg"];
    
}



#pragma mark - JRUpdateDownloadProtocol
-(void)downLoadProgress:(CGFloat)progress{
    self.progress.doubleValue = progress * 100;
}

-(void)downloaderDidFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
}


-(void)downloadFinishWithDestinationName:(NSString*)destinationName
                      temporaryDirectory:(NSString *)temporaryDirectory{
    
    [JRUpdateHelper AutoUpdateWithAppName:@"ShadowsocksX-NG.app" zipPath:destinationName destPath:temporaryDirectory];
    
}

@end
