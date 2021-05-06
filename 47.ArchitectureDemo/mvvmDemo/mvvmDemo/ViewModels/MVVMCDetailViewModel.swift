//
//  MVVMCDetailViewModel.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import Foundation

class MVVMCDetailViewModel: DetailViewModel{
    
    weak var viewDelegate: DetailViewModelViewDelegate?
    weak var coordinatorDelegate: DetailViewModelCoordinatorDelegate?
    
    fileprivate(set) var detail: DataItem? {
        didSet {
            viewDelegate?.detailDidChange(viewModel: self)
        }
    }
    
    
    var model: DetailModel? {
        didSet {
            model?.detail({ (item) in
                self.detail = item
            })
        }
    }
    
    func done() {
        coordinatorDelegate?.detailViewModelDidEnd(self)
    }
    
}
