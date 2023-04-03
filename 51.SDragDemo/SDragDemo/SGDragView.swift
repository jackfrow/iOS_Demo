//
//  SGDragView.swift
//  SDragDemo
//
//  Created by jackfrow on 2023/4/3.
//

import UIKit
import Foundation

class SGDragView: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    func commonUI() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(ges:)))
        self.addGestureRecognizer(pan)
    }
    
    
    @objc func panGestureAction(ges:UIPanGestureRecognizer)  {
//        CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
        
        let translation = ges.translation(in: ges.view)
        
        print("translation = \(translation)")
        
        //修改位置
        self.y = self.y + translation.y
        
        
        if ges.state == .failed || ges.state == .ended{
            if self.y > UIScreen.main.bounds.height - 400{
                UIView.animate(withDuration: 0.3) {
                    self.y = UIScreen.main.bounds.height - 150
                }
            }
        }
    
        //重置手势
        ges.setTranslation(.zero, in: self)
        
    }
    
    // MARK: - lazy
    
}
