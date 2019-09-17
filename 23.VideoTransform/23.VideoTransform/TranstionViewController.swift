//
//  TranstionViewController.swift
//  23.VideoTransform
//
//  Created by yy on 2019/9/11.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit
import AVFoundation

class TranstionViewController: UIViewController {

    var player:AVPlayer!
    var playerLayer:AVPlayerLayer!
    let editor = JRVideoEditor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        
         //加载bundle中的视频
        var videos:[AVAsset] = []
        
                 guard let urls = Bundle.main.urls(forResourcesWithExtension: ".mp4", subdirectory: nil) else {
                     return
                 }
        
        
     
        for  url in urls {

            let asset = AVAsset(url: url)
 
            videos.append(asset)
            
        }
    
    
        editor.assets = videos
        editor.buildComposition()
        
        let playerItem = AVPlayerItem(asset: editor.compostion)
        playerItem.videoComposition = editor.videoComposition
        player = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height - 200)
        playerLayer.position = view.center
        view.layer.addSublayer(playerLayer)
    }
    
    
    
    @IBAction func play(_ sender: Any) {
        
        player.play()
        
    }
    
    @IBAction func stop(_ sender: Any) {
    
        player.pause()
        
    }
    
    @IBAction func reset(_ sender: Any) {
        
        player.seek(to: CMTime.zero)
        
    }
    
    @IBAction func export(_ sender: Any) {
        
        editor.export()
        
    }
    
    
}
