//
//  RecordVideoViewController.swift
//  21.VideoDemo
//
//  Created by yy on 2019/9/7.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit
import MobileCoreServices

class RecordVideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func Record(_ sender: Any) {
        
        VideoHelper.showPicker(delegate: self, sourceType: .camera)
        
    }
    
}

extension RecordVideoViewController: UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //dismiss
        dismiss(animated: true, completion: nil)
        
        guard let mediaType =  info[.mediaType] as? String, mediaType == (kUTTypeMovie as String),let url =  info[.mediaURL] as? URL, UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path) else {
            return
        }
        
        //save movie
        UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)

    }
    
    
  @objc  func video(_ videoPath: String, didFinishSavingWithError error: Error?,contextInfo info: AnyObject)  {
        let title = (error == nil) ? "Success" : "Error"
        let message = (error == nil) ? "Video was saved" : "Video faile to save"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

extension RecordVideoViewController: UINavigationControllerDelegate{
    
}
