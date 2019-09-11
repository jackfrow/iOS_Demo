//
//  VideoHelper.swift
//  21.VideoDemo
//
//  Created by yy on 2019/9/7.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit
import MobileCoreServices
import Photos

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
    
    
    //Deal orientaionTransrom
    func orientationFromTransform(_ transform: CGAffineTransform) -> (orientation: UIImage.Orientation, isPortrait: Bool){
        
        //default orientations
        var assetOrientation = UIImage.Orientation.up
        var isPortrait = false
         if transform.a == 0 && transform.b == 1.0 && transform.c == -1.0 && transform.d == 0 {
          assetOrientation = .right
          isPortrait = true
        } else if transform.a == 0 && transform.b == -1.0 && transform.c == 1.0 && transform.d == 0 {
          assetOrientation = .left
          isPortrait = true
        } else if transform.a == 1.0 && transform.b == 0 && transform.c == 0 && transform.d == 1.0 {
          assetOrientation = .up
        } else if transform.a == -1.0 && transform.b == 0 && transform.c == 0 && transform.d == -1.0 {
          assetOrientation = .down
        }
        
        return (assetOrientation,isPortrait)
        
    }
    
    
}



extension UIViewController{
    
    
    func checkPermission() {
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized: print("Access is granted by user")
        case .restricted: print("User do not have access to photo album.")
        case .denied:  print("User has denied the permission.")
        case .notDetermined: PHPhotoLibrary.requestAuthorization { (newStatus) in
            print("status is \(newStatus)")
            if newStatus == PHAuthorizationStatus.authorized { print("success") }
            }
        @unknown default: break
            
        }
        
    }
    
    func savedPhotosAvailable() -> Bool {
        
        checkPermission()
        
           guard !UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) else { return true }
    
           let alert = UIAlertController(title: "Not Available", message: "No Saved Album found", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           present(alert, animated: true, completion: nil)
           return false
         }
    
}
