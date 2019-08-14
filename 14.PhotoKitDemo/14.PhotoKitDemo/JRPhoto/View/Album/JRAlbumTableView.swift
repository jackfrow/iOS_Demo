//
//  JRAlbumTableView.swift
//  14.PhotoKitDemo
//
//  Created by yy on 2019/8/13.
//  Copyright © 2019 xufanghao. All rights reserved.
//

import UIKit

fileprivate let cellIdentifier = "JRAlbumTableViewCell"

class JRAlbumTableView: UITableView{
    
    var assetCollectionList: [JRAlbumModel]?{
        didSet{
            reloadData()
        }
    }
    var selectAction: JRAlbumSelectAction?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setUpTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpTableView()  {
    
        register(UINib(nibName: cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)

        delegate = self
        dataSource = self
        tableFooterView = UIView()
    }

}

extension JRAlbumTableView: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let select = selectAction{
            let collection = assetCollectionList?[indexPath.row]
            select(collection)
        }

    }
    
}

extension JRAlbumTableView: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assetCollectionList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? JRAlbumTableViewCell else{
            fatalError("Unexpected cell in collection view")
        }
    
        guard let model = assetCollectionList?[indexPath.row] else {
            return cell
        }
        
        cell.model = model
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
