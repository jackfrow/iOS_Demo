//
//  AddOverlayViewController.swift
//  21.VideoDemo
//
//  Created by yy on 2019/9/9.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit
import AVFoundation


class AddOverlayViewController: CommonVideoController {

    var overlayImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Add Overlay"
        overlayImage = UIImage(named: "Frame-1")

    }
    
    
    @IBAction func FrameChange(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
                overlayImage = UIImage(named: "Frame-1")
            }else if sender.selectedSegmentIndex == 1{
                overlayImage = UIImage(named: "Frame-2")
            }else if sender.selectedSegmentIndex == 2{
             overlayImage = UIImage(named: "Frame-3")
            }
    
        
    }
    

    @IBAction func LoadAsset(_ sender: Any) {
     
        showPicker()
        
    }
    
    
    @IBAction func OutPut(_ sender: Any) {
        
        
        outPutFile()
        
    }
    
    override func applyVideoEffetctsToComposition(composition: AVMutableVideoComposition, size: CGSize) {
        
        // 1 - set up the overlay
        let overLayer = CALayer()
        overLayer.contents = overlayImage?.cgImage
        overLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        overLayer.masksToBounds = true
        
        //set text to view.
        //        let overLayer = CATextLayer()
        //        overLayer.string = "jackfrow"
        //        overLayer.frame = CGRect(x: 20, y: 20, width: 200, height: 40)
        
        
        //2 - set up the parent layer
        let parentLayer = CALayer()
        let videoLayer = CALayer()
        parentLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        videoLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        parentLayer.addSublayer(videoLayer)
        parentLayer.addSublayer(overLayer)
        
        // 3 - apply magic
        composition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: parentLayer)
        
    }
    
}
