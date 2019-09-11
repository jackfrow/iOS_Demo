//
//  AddSubTitleViewController.swift
//  21.VideoDemo
//
//  Created by yy on 2019/9/9.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit
import AVFoundation

class AddSubTitleViewController: CommonVideoController {

    
    @IBOutlet weak var WaterMarkField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Add subTitle"
        
    }
    
    
    @IBAction func LoadAsset(_ sender: Any) {
        
        showPicker()
        
    }
    
    @IBAction func OutPut(_ sender: Any) {
        
        outPutFile()
        
    }
    
    
    override func applyVideoEffetctsToComposition(composition: AVMutableVideoComposition, size: CGSize) {
        
        
        // 1 - Set up the text layer
        let subtitle1Text = CATextLayer()
        subtitle1Text.font = "Helvetica-Bold" as CFTypeRef
        subtitle1Text.fontSize = 36
        subtitle1Text.frame = CGRect(x: 0, y: 0, width: size.width, height: 100)
        subtitle1Text.string = WaterMarkField.text
        subtitle1Text.alignmentMode = .center
        subtitle1Text.foregroundColor = UIColor.white.cgColor
        
        
        //2 - The usual overlay
        let overlayLayer = CALayer()
        overlayLayer.addSublayer(subtitle1Text)
        overlayLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        overlayLayer.masksToBounds = true
        
        let parentLayer = CALayer()
        let videoLayer = CALayer()
        
        parentLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        videoLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        parentLayer.addSublayer(videoLayer)
        parentLayer.addSublayer(overlayLayer)
        
        // 3 - apply magic
        composition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: parentLayer)
    
    }
    
}
