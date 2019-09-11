//
//  AddAnimationViewController.swift
//  21.VideoDemo
//
//  Created by yy on 2019/9/9.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit
import AVFoundation

class AddAnimationViewController: CommonVideoController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Add Animation"
       
    }
    
    @IBAction func LoadAsset(_ sender: Any) {
        
        showPicker()
        
    }
    
    @IBAction func OutPut(_ sender: Any) {
        
        outPutFile()
        
    }
    
    override func applyVideoEffetctsToComposition(composition: AVMutableVideoComposition, size: CGSize) {
        
        //1.overlay
        let animationImage = UIImage(named: "star.png")
        let overlayLayer1 = CALayer()
        overlayLayer1.contents = animationImage?.cgImage
        overlayLayer1.frame = CGRect(x: size.width/2 - 64, y: size.height/2 + 200, width:128, height: 128)
        overlayLayer1.masksToBounds = true
        
        
        let overlayLayer2 = CALayer()
        overlayLayer2.contents = animationImage?.cgImage
        overlayLayer2.frame = CGRect(x: size.width/2 - 64 , y: size.height/2 - 200, width: 128, height: 128)
        overlayLayer2.masksToBounds = true
        
        //2 add animations
        //2.1 rotate
//        let animation = CABasicAnimation(keyPath: "transform.rotation")
//        animation.duration = 2.0
//        animation.repeatCount = 5
//        animation.autoreverses = true
//         // rotate from 0 to 360
//        animation.fromValue = NSNumber(floatLiteral: 0.0)
//        animation.toValue = NSNumber(floatLiteral: (2 * Double.pi))
//        animation.beginTime = AVCoreAnimationBeginTimeAtZero
//
//        overlayLayer1.add(animation, forKey: "rotation")
//        overlayLayer2.add(animation, forKey: "rotation")
        
        //2.2 - opacity
//        let animationOpacity = CABasicAnimation(keyPath: "opacity")
//            animationOpacity.duration = 3.0
//            animationOpacity.repeatCount = 5
//            animationOpacity.autoreverses = true
//             //  animate from invisible to fully visible
//        animationOpacity.fromValue = NSNumber(floatLiteral: 1.0)
//        animationOpacity.toValue = NSNumber(floatLiteral: 0.0)
//            animationOpacity.beginTime = AVCoreAnimationBeginTimeAtZero
//
//            overlayLayer1.add(animationOpacity, forKey: "animateOpacity")
//            overlayLayer2.add(animationOpacity, forKey: "animateOpacity")
        //2.3 - Twinkle
        let animationScale = CABasicAnimation(keyPath: "transform.scale")
              animationScale.duration = 1.0
              animationScale.repeatCount = 5
              animationScale.autoreverses = true
               //  // animate from half size to full size
        animationScale.fromValue = NSNumber(floatLiteral: 0.5)
        animationScale.toValue = NSNumber(floatLiteral: 1.0)
        animationScale.beginTime = AVCoreAnimationBeginTimeAtZero
          
        overlayLayer1.add(animationScale, forKey: "scale")
        overlayLayer2.add(animationScale, forKey: "scale")
        
        //3 - Composition
        let parentLayer = CALayer()
        let videoLayer = CALayer()
        parentLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        videoLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        parentLayer.addSublayer(videoLayer)
        parentLayer.addSublayer(overlayLayer1)
        parentLayer.addSublayer(overlayLayer2)
        
        composition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: parentLayer)
    
    }
    

}
