//
//  AppCoordinator.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import UIKit

class AppCoordinator:Coordinator{
    
    
    fileprivate let AUTHENTICATION_KEY: String  = "Authentication"
    fileprivate let LIST_KEY: String  = "List"
    
    var window: UIWindow
    var coordinators = [String:Coordinator]()
    
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start() {
        
        if isLoggedIn {
            showList()
        }else{
            showAuthentication()
        }
        
    }
    
}

extension AppCoordinator:AuthenticationCoordinatorDelegate{
   
    
    var isLoggedIn: Bool {
        return true;
    }
    func showAuthentication()
    {
        let authenticationCoordinator = AuthenticationCoordinator(window: window)
        coordinators[AUTHENTICATION_KEY] = authenticationCoordinator
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
    }
    
    
    func authenticationCoordinatorDidFinish(authenticationCoordinator: AuthenticationCoordinator) {
        coordinators[AUTHENTICATION_KEY] = nil
        showList()
    }
    
    
}

extension AppCoordinator:ListCoordinatorDelegate{

    
    func showList()
    {
        let listCoordinator = ListCoordinator(window: window)
        coordinators[LIST_KEY] = listCoordinator
        listCoordinator.delegate = self
        listCoordinator.start()
    }
    
    func listCoordinatorDidFinish(listCoordinator: ListCoordinator) {
        coordinators[LIST_KEY] = nil
    }
    
}



