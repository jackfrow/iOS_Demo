//
//  ListCoordinator.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import UIKit


protocol ListCoordinatorDelegate: class
{
    func listCoordinatorDidFinish(listCoordinator: ListCoordinator)
}

class ListCoordinator: Coordinator {
    
    
    weak var delegate: ListCoordinatorDelegate?
    var window: UIWindow
    var detailCoordinator: DetailCoordinator?
    var listViewController: MVVMCListViewController?
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "MVVM", bundle: nil)
        
         listViewController = storyboard.instantiateViewController(withIdentifier: "List") as? MVVMCListViewController
        guard let listViewController = listViewController else { return }
        
        let viewModel =  MVVMCListViewModel()
        viewModel.coordinatorDelegate = self
        viewModel.model = MVVMCListModel()
        listViewController.viewModel = viewModel
        
        
        window.rootViewController = listViewController
    }
    
}

extension ListCoordinator: ListViewModelCoordinatorDelegate
{
    func listViewModelDidSelectData(_ viewModel: ListViewModel, data: DataItem)
    {
        detailCoordinator = DetailCoordinator(window: window, dataItem: data)
        detailCoordinator?.delegate = self
        detailCoordinator?.start()
    }
}


extension ListCoordinator: DetailCoordinatorDelegate
{
    func detailCoordinatorDidFinish(detailCoordinator: DetailCoordinator)
    {
        self.detailCoordinator = nil
        window.rootViewController = listViewController
    }
}
