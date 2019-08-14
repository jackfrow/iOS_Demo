//
//  JRAlbumModel.swift
//  14.PhotoKitDemo
//
//  Created by yy on 2019/8/12.
//  Copyright © 2019 xufanghao. All rights reserved.
//

import Foundation
import Photos

class JRAlbumModel{
    
    //相册
    var collection: PHAssetCollection? {
        
        didSet{

            guard let collection = collection else {
                return
            }
            
            print("collectionTitle = \(collection.localizedTitle ?? "")")
            
            if collection.localizedTitle == "All Photos" {
                self.collectionTitle = "全部相册"
            }else{
                self.collectionTitle = collection.localizedTitle ?? ""
            }
            
            //获取某个相册中的所有PHAsset对象
            self.assets = PHAsset.fetchAssets(in:collection , options: nil)
            
            guard let asset = self.assets else {
                return
            }
            
            if asset.count > 0 {
                self.firstAsset = asset[0]
            }
            
            self.collectionNumber =   asset.count
            
        }
    }
    //第一个相片
    var firstAsset : PHAsset?
    //所有相片
    var assets : PHFetchResult<PHAsset>?
    //相册名
    var collectionTitle : String
    //总相片数
    var collectionNumber : Int
    
    lazy var selectRows: [NSNumber] = {
        
        var rows = [NSNumber]()

        return rows
    }()
    

    init(collection: PHAssetCollection? = nil,firstAsset: PHAsset? = nil ,assets: PHFetchResult<PHAsset>? = nil ,collectionTitle: String = "" ,collectionNumber: Int = 0) {
        
        self.collection = collection
        self.firstAsset = firstAsset
        self.assets = assets
        self.collectionTitle = collectionTitle
        self.collectionNumber = collectionNumber
        
    }
    
    
}
