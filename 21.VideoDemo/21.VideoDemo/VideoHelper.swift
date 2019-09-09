//
//  VideoHelper.swift
//  21.VideoDemo
//
//  Created by yy on 2019/9/7.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit
import MobileCoreServices

class VideoHelper: NSObject {

 static func showPicker(delegate: (UIViewController & UIImagePickerControllerDelegate & UINavigationControllerDelegate), sourceType: UIImagePickerController.SourceType)  {
     
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
    
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        //设置视屏清晰度,默认为中等
        picker.videoQuality = .typeHigh
//        picker.allowsEditing = true
        picker.mediaTypes = [kUTTypeMovie as String]
        picker.delegate = delegate
        delegate.present(picker, animated: true, completion: nil)
    }
    
}
