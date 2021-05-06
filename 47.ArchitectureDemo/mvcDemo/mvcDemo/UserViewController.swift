//
//  ViewController.swift
//  mvcDemo
//
//  Created by jackfrow on 2021/5/5.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    
    fileprivate var usersToDisplay = [UserViewData]()
    
    fileprivate let userService:UserService
    
    init(userService:UserService) {
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.userService = UserService()
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
   }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        activityIndicator.hidesWhenStopped = true
        getUsers()
    
    }
    
    
     func getUsers()  { 
       startLoading()
        userService.getUsers { (users) in
            self.finishLoading()
            
            if users.count == 0 {
                self.setEmptyUsers()
            }else{
                let mappedUsers = users.map { (user) -> UserViewData in
                    return UserViewData(name: "\(user.firstName) \(user.lastName)", age: "\(user.age)")
                }
                self.setUsers(mappedUsers)
            }
        }
    }
}


extension UserViewController{
    
    func startLoading()  {
        activityIndicator.startAnimating()
    }
    
    func finishLoading() {
        activityIndicator.stopAnimating()
    }
    
    func setUsers(_ users: [UserViewData]) {
        usersToDisplay = users
        tableView.isHidden = false
        emptyView.isHidden = true
        tableView.reloadData()
    }
    
    func setEmptyUsers() {
        tableView.isHidden = true
        emptyView.isHidden = false
    }
}

extension UserViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "UserCell")
        let userViewData = usersToDisplay[indexPath.row]
        cell.textLabel?.text = userViewData.name
        cell.detailTextLabel?.text = userViewData.age
        return cell
    }
    
}

