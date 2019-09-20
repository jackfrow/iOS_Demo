//
//  UIImage+TileCutter.swift
//  24.CalayerTutorial
//
//  Created by yy on 2019/9/19.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit


extension UIImage {
  
  class func saveTileOfSize(_ size: CGSize, name: String) -> () {
    let cachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as String
    let filePath = "\(cachesPath)/\(name)_0_0.png"
    let fileManager = FileManager.default
    let fileExists = fileManager.fileExists(atPath: filePath)
        
    if fileExists == false {
      var tileSize = size
      let scale = Float(UIScreen.main.scale)
      
      if let image = UIImage(named: "\(name).jpg") {
        let imageRef = image.cgImage
        let totalColumns = Int(ceilf(Float(image.size.width / tileSize.width)) * scale)
        let totalRows = Int(ceilf(Float(image.size.height / tileSize.height)) * scale)
        let partialColumnWidth = Int(image.size.width.truncatingRemainder(dividingBy: tileSize.width))
        let partialRowHeight = Int(image.size.height.truncatingRemainder(dividingBy: tileSize.height))
        
        DispatchQueue.global(qos: .default).async {
          for y in 0..<totalRows {
            for x in 0..<totalColumns {
              if partialRowHeight > 0 && y + 1 == totalRows {
                tileSize.height = CGFloat(partialRowHeight)
              }
              
              if partialColumnWidth > 0 && x + 1 == totalColumns {
                tileSize.width = CGFloat(partialColumnWidth)
              }
              
              let xOffset = CGFloat(x) * tileSize.width
              let yOffset = CGFloat(y) * tileSize.height
              let point = CGPoint(x: xOffset, y: yOffset)
              
                if let tileImageRef = imageRef?.cropping(to: CGRect(origin: point, size: tileSize)), let imageData = UIImage(cgImage: tileImageRef).pngData() {
                let path = "\(cachesPath)/\(name)_\(x)_\(y).png"
                try? imageData.write(to: URL(fileURLWithPath: path), options: [])
              }
            }
          }
        }
      }
    }
  }
  
}
