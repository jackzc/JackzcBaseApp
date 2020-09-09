//
//  AppRootViewController.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/1.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit
import SnapKit

class AppRootViewController: AppBaseRootViewController {
    
    override var vcTitle: String{
        set{}
        get{
            return "JackzcBase"
        }
    }
    override var AppDic: [String : AppBaseViewController.Type]{
        set{}
        get{
            return ["1.TableView系列":TableRootViewController.self,
                    "2.APP架构系列":ArchitectureRootViewController.self,
                    "3.常用框架":FrameWorkRootViewController.self,
                    "4.设计模式":DesignPatternRootViewController.self,
                    "5.HybridApp":HybridAppRootViewController.self,
                    "6.GPUImage使用":GPUImageAppRootViewController.self,
                    "7.Charts图表":ChartsAppRootViewController.self,
                    "Test":AppBaseViewController.self]
        }
    }
    override func didSelectItemInTableViewAtRow(_ indexPath: IndexPath) {
        let classType = self.AppDic[self.tableArray[indexPath.row]]
        if let className = classType {
            let vc = className.init()
            vc.title = self.tableArray[indexPath.row]
            let navigationVC = AppBaseNavigationController(rootViewController: vc)
            App.keyWindow?.rootViewController = navigationVC
        };
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
