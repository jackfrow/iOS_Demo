//
//  FriendTableViewController.swift
//  ProtocolDemo
//
//  Created by jackfrow on 2019/10/10.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import UIKit


class FriendTableViewController: UITableViewController {

    var nextPageState = NextPageState<Int>()
    var data: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadNext()
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == data.count - 1 {
            loadNext()
        }
        
    }
    
}

extension FriendTableViewController: NextPageLoadable{
  
    func performLoad(successHandler: ([Friend], Bool, Int?) -> (), failHandler: () -> ()) {
        
        //在这里发起网络请求
        
       let random = arc4random()%10
        if random > 5 {
            
            successHandler([Friend(name: "杰克马")],true,9527)
            
        }else{
            failHandler()
        }
    }
}
