//
//  MVVMCDetailViewController.swift
//  mvvmDemo
//
//  Created by jackfrow on 2021/5/6.
//

import UIKit

class MVVMCDetailViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    
    fileprivate var isLoaded: Bool = false
    
    
    var viewModel: DetailViewModel? {
        willSet {
            viewModel?.viewDelegate = nil
        }
        didSet {
            viewModel?.viewDelegate = self
            refreshDisplay()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    fileprivate func refreshDisplay()
    {
        guard isLoaded else { return }
        if let viewModel = viewModel {
            nameLabel.text = viewModel.detail?.name
            roleLabel.text = viewModel.detail?.role
        } else {
            nameLabel.text = ""
            roleLabel.text = ""
        }
    }

    @IBAction func done(_ sender: UIButton) {
        
        viewModel?.done()
    }
}


extension MVVMCDetailViewController: DetailViewModelViewDelegate
{
    func detailDidChange(viewModel: DetailViewModel)
    {
        refreshDisplay()
    }
}
