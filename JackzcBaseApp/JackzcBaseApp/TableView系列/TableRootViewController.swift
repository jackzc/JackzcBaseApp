
//
//  TableRootViewController.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/1.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

class TableRootViewController: AppBaseRootViewController {
    
    override var vcTitle: String{
        set{}
        get{
            return "表视图系列"
        }
    }
    
    override var AppDic: [String : AppBaseViewController.Type]{
        set{}
        get{
            return ["1.复杂表格表视图":VariousCellViewController.self,
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

