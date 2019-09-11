//
//  AddBorderViewController.swift
//  21.VideoDemo
//
//  Created by yy on 2019/9/9.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit
import AVFoundation

class AddBorderViewController: CommonVideoController {

    var borderColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add border"
        borderColor = UIColor.red

    }
    

    @IBAction func LoadAsset(_ sender: Any) {
        
        showPicker()
        
    }
    
    
    @IBAction func SegmentPicker(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            borderColor = UIColor.red
        }else if sender.selectedSegmentIndex == 1{
            borderColor = UIColor.green
        }else if sender.selectedSegmentIndex == 2{
            borderColor = UIColor.yellow
        }else if sender.selectedSegmentIndex == 3{
            borderColor = UIColor.systemPink
        }
        
        
    }
    
    @IBAction func OutputAsset(_ sender: Any) {
        outPutFile()
    }
    
    override func applyVideoEffetctsToComposition(composition: AVMutableVideoComposition, size: CGSize) {
        
        guard  let borderColor = borderColor else {
            return
        }
        
        let borderImage = UIImage.imageFromColor(color: borderColor, imageSize: CGRect(origin: .zero, size: size))
        
        let backgroundLayer = CALayer()
        backgroundLayer.contents = borderImage.cgImage
        backgroundLayer.frame = CGRect(origin: .zero, size: size)
        backgroundLayer.masksToBounds = true
        
        
        let videoLayer = CALayer()
        let margin: CGFloat = 10
        videoLayer.frame = CGRect(x: margin, y: margin, width: size.width - margin * 2, height: size.height - margin * 2)
        
        let parentLayer = CALayer()
        parentLayer.frame = CGRect(origin: .zero, size: size)
        parentLayer.addSublayer(backgroundLayer)
        parentLayer.addSublayer(videoLayer)
        
        composition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: parentLayer)
    
    }
    
    
}
