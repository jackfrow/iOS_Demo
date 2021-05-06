//
//  MVVMCDetailModel.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import Foundation


class MVVMCDetailModel: DetailModel{
    
    
    fileprivate var item: DataItem?
    
    init(detailItem: DataItem)
    {
        self.item = detailItem
    }
    
    func detail(_ completionHandler: @escaping (_ item: DataItem?) -> Void)
    {
        // Simulate Aysnchronous data access
        DispatchQueue.global().async {
            completionHandler(self.item)
        }
    }
    
}
