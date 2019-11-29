//
//  ChannelsTableViewController.swift
//  ProtocolDemo
//
//  Created by jackfrow on 2019/10/10.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import UIKit

class ChannelsTableViewController: UITableViewController {

    var data: [Channel] = []
     var nextPageState =  NextPageState<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

           loadNext()
        
    }

}

extension ChannelsTableViewController: NextPageLoadable{
    
    func performLoad(successHandler: ([Channel], Bool, Int?) -> (), failHandler: () -> ()) {
        
                //在这里发起网络请求
               let random = arc4random()%10
                if random > 5 {
                    
            successHandler([Channel(chName: "中国皇家戏剧学院")],true,9528)
        
                }else{
                    failHandler()
                }
    
    }
    
}

