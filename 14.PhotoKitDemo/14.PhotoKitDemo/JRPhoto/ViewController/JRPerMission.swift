//
//  JRPerMission.swift
//  14.PhotoKitDemo
//
//  Created by yy on 2019/8/12.
//  Copyright © 2019 xufanghao. All rights reserved.
//

import UIKit
import Photos

class JRPerMission: NSObject {

    class  func registerPhotoPermisson(finishBlock: (()->Void)?) {
        
      let status = PHPhotoLibrary.authorizationStatus()
        if status == .authorized {
            //回调
            if let finishBlock = finishBlock {
                finishBlock()
            }
            
        }else if status == .denied{
            
            goSetting()

        }else if status == .notDetermined{
            
            PHPhotoLibrary.requestAuthorization { (status) in
            
                if status == .authorized{
                    if let finishBlock = finishBlock {
                        finishBlock()
                    }
                }else if status == .denied{
               
                    goSetting()

                }
                
            }
            
        }
        
    }
    
  fileprivate class func goSetting()  {
    
        DispatchQueue.main.async {
            
            if let url = URL(string: UIApplication.openSettingsURLString){
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url, options:[:], completionHandler: nil)
                }
            }

        }
        
    }
    
}
