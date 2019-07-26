//
//  ViewController.swift
//  08-UIScrollViewDynamic
//
//  Created by jackfrow on 2019/2/11.
//  Copyright © 2019 jackfrow. All rights reserved.
//

//参考链接:https://stackoverflow.com/questions/10518790/how-to-set-content-size-of-uiscrollview-dynamically

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        //🌰
        let scrollView = UIScrollView()
        scrollView.contentSize = calculateContentSize(scrollView: scrollView)
        
        //🌰2
        scrollView.updateContentView()
        
        
    }


}


func calculateContentSize(scrollView: UIScrollView) -> CGSize {
    var topPoint = CGFloat()
    var height = CGFloat()
    
    for subview in scrollView.subviews {
        if subview.frame.origin.y > topPoint {
            topPoint = subview.frame.origin.y
            height = subview.frame.size.height
        }
    }
    return CGSize(width: scrollView.frame.size.width, height: height + topPoint)
}

extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
}

