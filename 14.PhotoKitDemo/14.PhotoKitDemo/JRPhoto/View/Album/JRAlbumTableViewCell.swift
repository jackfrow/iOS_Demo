//
//  JRAlbumTableViewCell.swift
//  14.PhotoKitDemo
//
//  Created by yy on 2019/8/13.
//  Copyright © 2019 xufanghao. All rights reserved.
//

import UIKit
import Photos

class JRAlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var albumName: UILabel!
    
    @IBOutlet weak var albumCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    
    var model : JRAlbumModel?{
        didSet{
            
            guard let modelInfo = model else {
                return
            }
            
            albumName.text = modelInfo.collectionTitle
            albumCount.text = "\(modelInfo.collectionNumber)"
            
            guard let asset = modelInfo.firstAsset else {
                return
            }
            
            let size = CGSize(width: screenWidth/2.0, height: screenWidth/2.0)
            
            PHCachingImageManager.default().requestImage(for:asset, targetSize: size, contentMode: .default, options: nil) { (image, _) in
                
              self.albumImage.image = image
                
            }
            
        }
    }
    
    
}
