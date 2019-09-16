//
//  ViewController.swift
//  23.VideoTransform
//
//  Created by yy on 2019/9/11.
//  Copyright © 2019 Jackfrow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    
    lazy var dataSource: [String] = {
        
        let data = ["转场动画"]
        
        return data
    }()

}


extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = dataSource[indexPath.row]
        
        guard  let  finalCell = cell else {
            return UITableViewCell()
        }
        
        return finalCell
        
    }
    

    
}


extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TranstionViewController")
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
