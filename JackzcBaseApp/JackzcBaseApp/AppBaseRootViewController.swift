



//
//  AppBaseRootViewController.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/23.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

protocol JackzcViewControllerProtocol {
     var vcTitle:String{get}
     var AppDic:[String: UIViewController.Type]{get}
     func titleForCurrentViewController() -> Void
     func tableDicForCurrentViewController() -> Void
}

extension AppBaseRootViewController:JackzcViewControllerProtocol{
    func titleForCurrentViewController() {
        
    }
    
    func tableDicForCurrentViewController() {
        
    }
    
    var vcTitle: String {
        get {
            return "testVC"
        }
    }
    var AppDic: [String : UIViewController.Type] {
        get {
            return ["TableView系列":TableRootViewController.self,
                          "架构系列":ArchitectureRootViewController.self,
                          "常用框架":FrameWorkRootViewController.self,
                          "设计模式":DesignPatternRootViewController.self,
                             "Test":AppBaseViewController.self
                    ]
        }
        
    }
}

class AppBaseRootViewController: AppBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
