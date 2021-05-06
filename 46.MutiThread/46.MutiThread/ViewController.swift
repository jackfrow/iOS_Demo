//
//  ViewController.swift
//  46.MutiThread
//
//  Created by jackfrow on 2021/4/28.
//

import UIKit

class ViewController: JRListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "多线程使用"
        loadData()
        
    }
    
    override func loadCellModelMapping() {
        registerModelClass(TestModel.self, mappedCellClass: TestCell.self)
    }
    
    func loadData()  {
        
        
        for item in [CPthreadUse,
                     CPthreads,
                     CPthreads2,
                     CNSThreadUse,
                     CNSThread1,
                     CNSThread2,
                     CNSThread3,
                     COPreationUse,
                     COPreation1,
                     COPreation2,
                     COPreation3,
                     COPreation4,
                     COPreation5,
                     COPreation6,
                     COPreation7,
                     CGCDUse,
                     CGCD1,
                     CGCD2,
                     CGCD3,
                     CGCD4,
                     CGCD5,
                     CGCD6,
                     CGCD7,
                     CGCDOther,
                     CGCDOther1,
                     CGCDOther2,
                     CGCDOther3,
                     CGCDOther4,
                     CGCDOther5,
                     CGCDOther6,
                     CGCDOther7,
                     CGCDOther8] {
            let m1 = TestModel(title: item)
            models.add(m1)
        }
        
       
    
        tableView.reloadData()
        
    
        
    
    }
    
    
    //MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let model = self.model(at: indexPath)
        if let model = model as? TestModel {
            switch model.title {
            case CPthreads:
                PthreadDemo1()
            case CPthreads2:
                PthreadDemo2()
            case CNSThread1:
                JRThread().NSThreadDemo1()
            case CNSThread2:
                JRThread().NSThreadDemo2()
            case CNSThread3:
                JRThread().NSThreadDemo3()
            case COPreation1:
                OPreationDemo().testDemo1()
            case COPreation2:
                OPreationDemo().testDemo2()
            case COPreation3:
                OPreationDemo().testDemo3()
            case COPreation4:
                OPreationDemo().testDemo4()
            case COPreation5:
                OPreationDemo().testDemo5()
            case COPreation6:
                OPreationDemo().testDemo6()
            case COPreation7:
                OPreationDemo().testDemo7()
            case CGCD1:
                JRGcd.syncConcurrent()
            case CGCD2:
                JRGcd.asyncConcurrent()
            case CGCD3:
                JRGcd.syncSerial()
            case CGCD4:
                JRGcd.asyncSerial()
            case CGCD5:
                JRGcd.syncMain()
            case CGCD6:
                JRGcd.asyncMain()
            case CGCD7:
                JRGcd.communication()
            case CGCDOther1:
                JRGcd.barrier()
            case CGCDOther2:
                JRGcd.after()
            case CGCDOther3:
                JRGcd.once()
            case CGCDOther4:
                JRGcd.apply()
            case CGCDOther5:
                JRGcd.groupNotify()
            case CGCDOther6:
                JRGcd.groupWait()
            case CGCDOther7:
                JRGcd.groupEnterAndLeave()
            case CGCDOther8:
                JRGcd.semaphoreSync()
            default:
                NSLog("invalid info ")
            }
        }
        
    }
    


}

