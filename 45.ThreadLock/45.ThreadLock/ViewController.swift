//
//  ViewController.swift
//  45.ThreadLock
//
//  Created by jackfrow on 2021/4/28.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {



    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "iOS中的锁"
    
        view.addSubview(self.tableView)
        
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let text = self.dataSouce[indexPath.row] as? String
        switch text {
        case  COSPinkLock:
            OSSpinLockTest()
        case CunfairLock:
            os_unfair_lockDemo()
        case CSemaphore:
            semaphoreTest()
        case  CPthread:
            PthreadTest()
        case CPthreadRecursive:
             PthreadRecursiveTest()
        case CNSLock:
            NSLockDemo()
        case CNSCondition1:
             NSConditionDemo1()
        case CNSCondition2:
             NSConditionDemo2()
        case  CNSCondition3:
             NSConditionDemo3()
        case CNSRecursiveLock:
            NSRecursiveLockDemo()
        case CSynchronized:
            let sync = Sync()
            sync.SynchronizedDemo()
        case CNSConditionLock:
            NSConditionLockDemo()
            
 
        default:
            break
        }
        
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSouce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = self.dataSouce[indexPath.row] as? String
        return cell!
    }


    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return  tableView
    }()
        
    lazy var dataSouce: NSArray = {
    
        let arr = [COSPinkLock,CunfairLock,CSemaphore,CPthread,CPthreadRecursive,CNSLock,CNSCondition1,CNSCondition2,CNSCondition3,CNSRecursiveLock,CSynchronized,CNSConditionLock]
     
        return arr as NSArray
    }()
    
}

