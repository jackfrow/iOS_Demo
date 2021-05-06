//
//  ViewController.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import UIKit

class MVVMCAuthenticationViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel: AuthenticateViewModel?{
        willSet{
            viewModel?.viewDelegate = nil
        }
        didSet{
            viewModel?.viewDelegate = self
            refreshDisplay()
        }
    }
    
    fileprivate var isLoaded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        isLoaded = true
        
        emailField.addTarget(self, action: #selector(emailFieldDidChange(_:)), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(passwordFieldDidChange(_:)), for: .editingChanged)
        
        refreshDisplay()
       
    }
    
    
    fileprivate func refreshDisplay()
    {
        guard isLoaded else { return }
        
        if let viewModel = viewModel {
            emailField.text = viewModel.email
            passwordField.text = viewModel.password
            errorMessageLabel.text = viewModel.errorMessage
            loginButton.isEnabled = viewModel.canSubmit
        } else {
            emailField.text = ""
            passwordField.text = ""
            errorMessageLabel.text = ""
            loginButton.isEnabled = false
        }
    }
    
    
    @objc func emailFieldDidChange(_ textField: UITextField)
    {
        if  let text = textField.text {
            viewModel?.email = text
        }
        
    }
    
    @objc func passwordFieldDidChange(_ textField: UITextField)
    {

        if let text = textField.text {
            viewModel?.password = text
        }
       
    }
    

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        viewModel?.submit()
    }
    
}


extension MVVMCAuthenticationViewController:AuthenticateViewModelViewDelegate{
    func canSubmitStatusDidChange(_ viewModel: AuthenticateViewModel, status: Bool) {
        loginButton.isEnabled = status
    }
    
    func errorMessageDidChange(_ viewModel: AuthenticateViewModel, message: String) {
        errorMessageLabel.text = message
    }
    
    
}
