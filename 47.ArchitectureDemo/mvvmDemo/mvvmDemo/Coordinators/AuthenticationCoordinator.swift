//
//  AuthenticationCoordinator.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import UIKit


protocol AuthenticationCoordinatorDelegate: class
{
    func authenticationCoordinatorDidFinish(authenticationCoordinator: AuthenticationCoordinator)
}

class AuthenticationCoordinator: Coordinator {
    
    
    weak var delegate: AuthenticationCoordinatorDelegate?
    let window: UIWindow
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "MVVM", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "Authentication") as? MVVMCAuthenticationViewController {
            let viewModel =  MVVMCAuthenticateViewModel()
            viewModel.model = MVVMCAuthenticateModel()
            viewModel.coordinatorDelegate = self
            vc.viewModel = viewModel
            window.rootViewController = vc
        }
    }
    
}


extension AuthenticationCoordinator:AuthenticateViewModelCoordinatorDelegate{
    func authenticateViewModelDidLogin(viewModel: AuthenticateViewModel)
    {
        delegate?.authenticationCoordinatorDidFinish(authenticationCoordinator: self)
    }
}
