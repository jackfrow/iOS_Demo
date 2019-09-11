//
//  AddTitleViewController.swift
//  21.VideoDemo
//
//  Created by yy on 2019/9/9.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit
import AVFoundation

class AddTiltViewController: CommonVideoController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Add Title"
        
        
        
    }
    
    @IBAction func LoadAsset(_ sender: Any) {
        
        showPicker()
        
    }
    
    @IBAction func OutPut(_ sender: Any) {
        
        outPutFile()
        
    }
    
    override func applyVideoEffetctsToComposition(composition: AVMutableVideoComposition, size: CGSize) {
        
        // 1 - Layer setup
        let parentLayer = CALayer()
        let videoLayer = CALayer()
        
        parentLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        videoLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        parentLayer.addSublayer(videoLayer)

        // 2 - Set up the transform
        var identityTransform = CATransform3DIdentity;
        
        //3 - set m34
        identityTransform.m34 = 1.0 / 1000;
        
        
        // 4 - Rotate
        videoLayer.transform = CATransform3DRotate(identityTransform, CGFloat(Double.pi/6), 1, 0, 0)
        
        // 5 - Composition
        composition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: parentLayer)
        
        
    }
    
    
}
