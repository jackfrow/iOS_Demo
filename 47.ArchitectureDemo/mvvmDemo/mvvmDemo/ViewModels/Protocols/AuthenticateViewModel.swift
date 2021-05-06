//
//  AuthenticateViewModel.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import Foundation


protocol AuthenticateViewModelViewDelegate: class  {
    func canSubmitStatusDidChange(_ viewModel: AuthenticateViewModel, status: Bool)
    func errorMessageDidChange(_ viewModel: AuthenticateViewModel, message: String)
}



protocol AuthenticateViewModelCoordinatorDelegate: class
{
    func authenticateViewModelDidLogin(viewModel: AuthenticateViewModel)
}


protocol AuthenticateViewModel
{
    var model: AuthenticateModel? { get set }
    var viewDelegate: AuthenticateViewModelViewDelegate? { get set }
    var coordinatorDelegate: AuthenticateViewModelCoordinatorDelegate? { get set}
    
    // Email and Password
    var email: String {get set}
    var password: String {get set}
    
    // Submit
    var canSubmit: Bool { get }
    func submit()
    
    // Errors
    var errorMessage: String { get }
}

