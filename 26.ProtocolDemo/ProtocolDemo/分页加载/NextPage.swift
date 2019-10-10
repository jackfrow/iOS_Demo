//
//  NextPage.swift
//  ProtocolDemo
//
//  Created by jackfrow on 2019/10/10.
//  Copyright © 2019 jackfrow. All rights reserved.
//

import Foundation
import UIKit


struct Friend {
    var name: String
}

struct Channel {
    var chName: String
    
}

struct NextPageState<T> {
    
    var hasNext: Bool
    var isLoading: Bool
    var lastId: T?
    
    init() {
        hasNext = true
        isLoading = false
        lastId = nil
    }
    
    
    mutating func reset(){
        hasNext = true
        isLoading = false
        lastId = nil
    }
    
    mutating func update(hasNext: Bool,isLoading: Bool,lastId: T?){
        self.hasNext = hasNext
        self.isLoading = isLoading
        self.lastId = lastId
    }
    
}

protocol NextPageLoadable: class {
    
    associatedtype DataType
    associatedtype LastIdType
    
    var data: [DataType] {get set}
    var nextPageState: NextPageState<LastIdType> {get set}
    
    func performLoad(
         successHandler:
        (_ rows: [DataType],
        _ hasNext: Bool,
        _ lastId: LastIdType?) -> (),
     failHandler: () -> ()
    )
}


protocol ReloadableType {
    func reloadData()
}

extension UITableView: ReloadableType{}
extension UICollectionView: ReloadableType{}

extension NextPageLoadable {
    func loadNext(view: ReloadableType)  {
        
        guard nextPageState.hasNext else {return}
        if nextPageState.isLoading {return}
        
        nextPageState.isLoading = true
        performLoad(successHandler: { (rows, hasNext, lastId) in
            self.data += rows
            self.nextPageState.update(hasNext: hasNext, isLoading: false, lastId: lastId)
            
            view.reloadData()
            
        }, failHandler: {
            
            print("load error")
            
        })
    }
}

extension NextPageLoadable where Self: UITableViewController {
    
    func loadNext()  {
        loadNext(view: tableView)
    }
    
}


extension NextPageLoadable where Self: UICollectionViewController{
   func loadNext()  {
        loadNext(view: collectionView)
    }
}
