//
//  ImageExtension.swift
//  14.PhotoKitDemo
//
//  Created by yy on 2019/8/12.
//  Copyright © 2019 xufanghao. All rights reserved.
//

import UIKit

func creatImageWithColor(color:UIColor)->UIImage{
    let rect = CGRect(x:0,y:0,width:1,height:1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context!.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}
