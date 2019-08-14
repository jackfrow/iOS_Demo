//
//  JRPhotoCell.swift
//  14.PhotoKitDemo
//
//  Created by yy on 2019/8/12.
//  Copyright © 2019 xufanghao. All rights reserved.
//

import UIKit
import Photos


class JRPhotoCell: UICollectionViewCell {

    @IBOutlet weak var ImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        ImgView.image = creatImageWithColor(color: UIColor.randomColor)
        
    }
    
    var photoAsset : PHAsset!{
        didSet{
        
            let width = (UIScreen.main.bounds.width - 4 - 10) / 3
            
            PHCachingImageManager.default().requestImage(for: photoAsset, targetSize: CGSize(width: width, height: width), contentMode: .aspectFill, options: nil) { (image, _ nil) in
            
                self.ImgView.image = image
            }
      
        }
    }


}
