//
//  FriendCollectionViewController.swift
//  ProtocolDemo
//
//  Created by jackfrow on 2019/10/10.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendCollectionViewController: UICollectionViewController {

    var data: [Friend] = []
    var nextPageState =  NextPageState<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNext()
        
    }
    
}

extension FriendCollectionViewController: NextPageLoadable{
    func performLoad(successHandler: ([Friend], Bool, Int?) -> (), failHandler: () -> ()) {
     
        //在这里发起网络请求
           let random = arc4random()%10
            if random > 5 {
                
                successHandler([Friend(name: "pony马")],true,9527)
                
            }else{
                failHandler()
            }
        
    }
    
    
}
