//
//  JRAlbumView.swift
//  14.PhotoKitDemo
//
//  Created by yy on 2019/8/12.
//  Copyright © 2019 xufanghao. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

typealias JRAlbumSelectAction = ((_ model: JRAlbumModel?) -> Void)

class JRAlbumView: UIView {
    
    var navigationBarMaxY : CGFloat = 0
    var selectAction : JRAlbumSelectAction?
    var presentHeight : Int = 0
    
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        setupAlbumView()
    }
    
    func setupAlbumView()  {
        UIApplication.shared.keyWindow?.addSubview(self)
        addSubview(greyTransparentButton)
        tableViewBackgroundView.addSubview(tableView)
        addSubview(tableViewBackgroundView)
    }
    
    class func showAlbumView(assetCollectionList: [JRAlbumModel],navigationBarMaxY: CGFloat,complete: JRAlbumSelectAction?)  {
        
        let albumView = JRAlbumView()
        albumView.navigationBarMaxY = navigationBarMaxY
        albumView.selectAction = complete
        albumView.assetCollectionList = assetCollectionList
    }
    
    @objc func cancelClick()  {
        
        guard let action = selectAction else {
            return
        }
        
        hideAnimate()
        
        action(nil)
        
    }
    
    var assetCollectionList: [JRAlbumModel]?{
        
        didSet{
            
            guard let assets = assetCollectionList else {
                return
            }
            
            presentHeight = assets.count * 80
            if presentHeight > 400 {
                presentHeight = 400
            }
            
            tableViewBackgroundView.frame = CGRect(x: 0, y: navigationBarMaxY, width: screenWidth, height: 0.001)
            
            tableView.assetCollectionList = assets
            tableView.frame.size.height = CGFloat(presentHeight)

             tableView.selectAction = {[unowned self] model in
                
                if let select = self.selectAction{
                    select(model)
                }
                self.hideAnimate()
            }
            showAnimate()
        }
    }
    
    //MARK: - show
    func showAnimate()  {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
            self.greyTransparentButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
            self.tableViewBackgroundView.frame.size.height = CGFloat(self.presentHeight)
        }, completion: nil)
        
    }
    
    //MARK: - hide
    func hideAnimate()  {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.greyTransparentButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            self.tableViewBackgroundView.frame.size.height = 0.001
        }) { (finish) in
            self.removeFromSuperview()
        }
        
    }
    
    
    //MARK: - lazy
    lazy var greyTransparentButton: UIButton = {
        
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        btn.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        btn.addTarget(self, action: #selector(JRAlbumView.cancelClick), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy var tableView: JRAlbumTableView = {
        let view = JRAlbumTableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), style: .plain)
        return view
    }()
    
    lazy var tableViewBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        return view
    }()
    

}
