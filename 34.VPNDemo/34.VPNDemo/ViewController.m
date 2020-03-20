//
//  ViewController.m
//  34.VPNDemo
//
//  Created by jackfrow on 2020/3/2.
//  Copyright © 2020 jackfrow. All rights reserved.
//

#import "ViewController.h"
#import "XmVpnManager.h"
#import "XmVpnManagerModel.h"
#import <NetworkExtension/NetworkExtension.h>
#import "LogViewController.h"

@interface ViewController ()<XDXVPNManagerDelegate>

@property (nonatomic, strong)           XmVpnManager   *vpnManager;
@property (weak, nonatomic) IBOutlet UIButton *connetBtn;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";
    
    self.connetBtn.layer.masksToBounds = true;
    self.connetBtn.layer.cornerRadius = 100;
   
    XmVpnManagerModel* model = [[XmVpnManagerModel alloc] init];
    
    /*  Note   - 在运行代码前必须按照博客所说配置好Target及开放权限，否则Demo无法正常运行
        *  @param TunnelBundleId : 必须填写你Extension Target的bundile ID,且必须合法，博客里有详细说明
        */
       [model configureInfoWithTunnelBundleId:@"test.psk4h6snx9.ppx.tunnel"
                                serverAddress:@"XDX"
                                   serverPort:@"54345"
                                          mtu:@"1400"
                                           ip:@"10.8.0.2"
                                       subnet:@"255.255.255.0"
                                          dns:@"8.8.8.8,8.4.4.4"];
    
    self.vpnManager = [[XmVpnManager alloc] init];
    [self.vpnManager testSave];
    
    
    [self.vpnManager configManagerWithModel:model];
    self.vpnManager.delegate = self;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vpnDidChange:) name:NEVPNStatusDidChangeNotification object:nil];

    
}


- (IBAction)showLog:(id)sender {
    
    LogViewController* vc = [[LogViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
    
    
}

#pragma mark - Notification
- (void)vpnDidChange:(NSNotification *)notification {

    
    OSStatus status = self.vpnManager.vpnManager.connection.status;

    switch (status) {
        case NEVPNStatusConnecting:
        {
            NSLog(@"Connecting...");
            [self.connetBtn setTitle:@"Disconnect" forState:UIControlStateNormal];
        }
            break;
        case NEVPNStatusConnected:
        {
            NSLog(@"Connected...");
            [self.connetBtn setTitle:@"Disconnect" forState:UIControlStateNormal];
            
        }
            break;
        case NEVPNStatusDisconnecting:
        {
            NSLog(@"Disconnecting...");
            
        }
            break;
        case NEVPNStatusDisconnected:
        {
            NSLog(@"Disconnected...");
            [self.connetBtn setTitle:@"Connect" forState:UIControlStateNormal];
            
        }
            break;
        case NEVPNStatusInvalid:
            
            NSLog(@"Invliad");
//             [self.connectBtn setTitle:@"Connect" forState:UIControlStateNormal];
            break;
        case NEVPNStatusReasserting:
            NSLog(@"Reasserting...");
            break;
    }
}


- (IBAction)didClickConnectBtn:(UIButton *)sender {
    
    if ([sender.currentTitle isEqualToString:@"Disconnect"]) {
         [self.vpnManager stopVPN];
      }else {
         [self.vpnManager startVPN];
      }
    

    
    
}



#pragma mark - Delegate
- (void)loadFromPreferencesComplete {
    [self vpnDidChange:nil];
}

#pragma mark - Dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
