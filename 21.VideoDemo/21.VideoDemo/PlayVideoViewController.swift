//
//  PlayVideoViewController.swift
//  21.VideoDemo
//
//  Created by yy on 2019/9/7.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit

class PlayVideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func play(_ sender: Any) {
        
        VideoHelper.showPicker(delegate: self, sourceType: .savedPhotosAlbum)
                
    }
    

}

extension PlayVideoViewController : UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //check info type and url if effective
        guard let mediaType = info[.mediaType] as? String, mediaType == (kUTTypeMovie as String),let url = info[.mediaURL] as? URL else { return }
        
        dismiss(animated: true) {
            let player = AVPlayer(url: url)
            let vcPlayer = AVPlayerViewController()
            vcPlayer.player = player
            self.present(vcPlayer, animated: true, completion: nil)
        }
        
       
        
    }
    
}

extension PlayVideoViewController: UINavigationControllerDelegate{
    
}


