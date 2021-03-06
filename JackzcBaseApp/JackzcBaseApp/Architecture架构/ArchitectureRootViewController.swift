
//
//  ArchitectureRootViewController.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/14.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

class ArchitectureRootViewController: AppBaseRootViewController {
    
    override var vcTitle: String{
        set{}
        get{
            return "架构系列"
        }
    }
    override var AppDic: [String : AppBaseViewController.Type]{
        set{}
        get{
            return ["1.MVC" :MVCViewController.self,
                    "2.MVP" :MVPViewController.self,
                    "3.MVVM":MVVMViewController.self,
                    "Test":AppBaseViewController.self]
        }
    }
    
    override func didSelectItemInTableViewAtRow(_ indexPath: IndexPath) {
        let classType = self.AppDic[self.tableArray[indexPath.row]]
        if let className = classType {
            let vc = className.init()
            vc.title = self.tableArray[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        };
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


