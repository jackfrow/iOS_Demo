//
//  UIimage+compress.swift
//  21.VideoDemo
//
//  Created by yy on 2019/9/9.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit

extension UIImage{
    
   class func imageFromColor(color: UIColor,imageSize: CGRect) -> UIImage {
        let rect = imageSize
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)// Fill it with your color
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    
}
