//
//  DetailCoordinator.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import UIKit


protocol DetailCoordinatorDelegate: class
{
    func detailCoordinatorDidFinish(detailCoordinator: DetailCoordinator)
}

class DetailCoordinator: Coordinator
{
    
    weak var delegate: DetailCoordinatorDelegate?
    let dataItem: DataItem
    var window: UIWindow
    
    
    init(window: UIWindow, dataItem: DataItem)
    {
        self.window = window
        self.dataItem = dataItem
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "MVVM", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "Detail") as? MVVMCDetailViewController {
            let viewModel =  MVVMCDetailViewModel()
            viewModel.model = MVVMCDetailModel(detailItem: dataItem)
            viewModel.coordinatorDelegate = self
            vc.viewModel = viewModel
            window.rootViewController = vc
        }
    }
    
    
}


extension DetailCoordinator: DetailViewModelCoordinatorDelegate
{
    
 func detailViewModelDidEnd(_ viewModel: DetailViewModel)
 {
    delegate?.detailCoordinatorDidFinish(detailCoordinator: self)
 }
    
}
