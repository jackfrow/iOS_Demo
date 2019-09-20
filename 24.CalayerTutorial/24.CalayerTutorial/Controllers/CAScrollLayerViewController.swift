//
//  CAScrollLayerViewController.swift
//  24.CalayerTutorial
//
//  Created by yy on 2019/9/18.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit

class CAScrollLayerViewController: UIViewController {

  
    @IBOutlet weak var scrollingView: ScrollingView!
    
    @IBOutlet weak var horizontalScrollingSwitch: UISwitch!
    
    @IBOutlet weak var verticalScrollingSwitch: UISwitch!
    
    
    var scrollingViewLayer: CAScrollLayer {
       return scrollingView.layer as! CAScrollLayer
     }
    
     // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollingViewLayer.scrollMode = .both
       
    }
    
    // MARK: - IBActions
    
    @IBAction func panRecognized(_ sender: UIPanGestureRecognizer) {
        
       
        var newPoint = scrollingView.bounds.origin
        newPoint.x -= sender.translation(in: scrollingView).x
        newPoint.y -= sender.translation(in: scrollingView).y
        sender.setTranslation(CGPoint.zero, in: scrollingView)
        scrollingViewLayer.scroll(to: newPoint)
        
        if sender.state == .ended {
            UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
            [unowned self] in
            self.scrollingViewLayer.scroll(to: CGPoint.zero)
            }, completion: nil)
        }
        
    }
    
    @IBAction func scrollingSwitchChanged(_ sender: Any) {
        
        switch (horizontalScrollingSwitch.isOn, verticalScrollingSwitch.isOn) {
          case (true, true):
            scrollingViewLayer.scrollMode = .both
          case (true, false):
            scrollingViewLayer.scrollMode = .horizontally
          case (false, true):
            scrollingViewLayer.scrollMode = .vertically
          default:
            scrollingViewLayer.scrollMode = .none
          }
        
    }
    
    


}
