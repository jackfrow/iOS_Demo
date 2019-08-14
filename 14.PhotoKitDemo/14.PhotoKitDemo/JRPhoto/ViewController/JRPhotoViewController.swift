//
//  JRPhotoViewController.swift
//  14.PhotoKitDemo
//
//  Created by yy on 2019/8/12.
//  Copyright © 2019 xufanghao. All rights reserved.
//

import UIKit
import Photos

fileprivate let cellIdentifier = "JRPhotoCell"

class JRPhotoViewController: UIViewController {
    
    var fetchResult: PHFetchResult<PHAsset>!
 
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = UIColor.white
        CustomUI()
        getThumbnailImages()
        
    }
    
    
    func CustomUI()  {
       
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 45))
        navigationItem.titleView = titleView
        titleView.addSubview(showAlbumButton)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action:#selector(leftAction))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: .plain, target: self, action: #selector(rightAction))
        
        view.addSubview(photoLibrary)
    }
    
    @objc func leftAction()  {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc func rightAction()  {
        
        print("确定")
        
    }
    
    lazy var photoLibrary: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let width = (UIScreen.main.bounds.width - 4 - 10) / 3
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        let collection = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.white
        
        collection.register(UINib(nibName: "JRPhotoCell", bundle:Bundle.main), forCellWithReuseIdentifier: cellIdentifier)
        collection.delegate = self
        collection.dataSource = self
        
        return collection
    }()
    
    
    lazy var showAlbumButton: UIButton = {
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 180, height: 45)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(JRPhotoViewController.showAlbum(btn:)), for: .touchUpInside)
        btn.setImage(UIImage(named: "down"), for: .normal)
        btn.setImage(UIImage(named: "up"), for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        
        return btn
        
    }()
    
    lazy var assetCollectionList: [JRAlbumModel] = {
        var models = [JRAlbumModel]()
        return models
    }()
    
    var albumModel: JRAlbumModel? {
        didSet{
            
            guard let albumModel = albumModel else {
                return
            }
            
            self.showAlbumButton.setTitle(albumModel.collectionTitle, for: .normal)
            self.photoLibrary.reloadData()
        }
    }
    
    @objc func showAlbum(btn : UIButton)  {
        btn.isSelected = !btn.isSelected
        
        let maxY = self.navigationController?.navigationBar.frame.maxY;
        
        JRAlbumView.showAlbumView(assetCollectionList: self.assetCollectionList, navigationBarMaxY: maxY ?? 0) { (model) in
            btn.isSelected = !btn.isSelected
            self.albumModel = model
        }
    
    }
    
    func getThumbnailImages()  {
        
        DispatchQueue.global().async {
        //获得个人收藏相册
         let favorites = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumFavorites, options: nil)
        //获得相机胶卷
        let asset = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .smartAlbumUserLibrary, options: nil)
        //获得全部相片
        let cameraRolls = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)

            //将所有相册遍历到数组中
            for result in [cameraRolls,favorites,asset]{
                
                result.enumerateObjects({ (collection, _, _) in
                    
                    let model = JRAlbumModel()
                    model.collection = collection
                    if model.collectionNumber != 0{
                    self.assetCollectionList.append(model)
                }
                    
                })
            }
            
            
            //设置选中的相册
            DispatchQueue.main.async {
            
               self.albumModel = self.assetCollectionList.first
                
            }
            
        }
        
        
        
    }
    
}

extension JRPhotoViewController : UICollectionViewDelegate{
    
}

extension JRPhotoViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumModel?.collectionNumber ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? JRPhotoCell
            else {
                fatalError("Unexpected cell in collection view")
        }
        
        guard let albumModel = albumModel,let asset = albumModel.assets?.object(at: indexPath.row) else {
            return cell
        }
        
        cell.photoAsset = asset
        
        return cell
        
    }
    
    
}

