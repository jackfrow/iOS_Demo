//
//  DetailViewModel.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import Foundation



protocol DetailViewModelViewDelegate: class
{
    func detailDidChange(viewModel: DetailViewModel)
}

protocol DetailViewModelCoordinatorDelegate: class
{
    func detailViewModelDidEnd(_ viewModel: DetailViewModel)
}

protocol DetailViewModel
{
    var model: DetailModel? { get set }
    var viewDelegate: DetailViewModelViewDelegate? { get set }
    var coordinatorDelegate: DetailViewModelCoordinatorDelegate? { get set}
    var detail: DataItem? { get }
    func done()
}
