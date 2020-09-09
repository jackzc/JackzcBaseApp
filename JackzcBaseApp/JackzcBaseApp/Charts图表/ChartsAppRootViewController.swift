//
//  ChartsAppRootViewController.swift
//  JackzcBaseApp
//
//  Created by zouchao on 2019/3/18.
//  Copyright © 2019年 silence. All rights reserved.
//

import UIKit

class ChartsAppRootViewController: AppBaseRootViewController {
    override var vcTitle: String{
        set{}
        get{
            return "Charts图表"
        }
    }
    override var AppDic: [String : AppBaseViewController.Type]{
        set{}
        get{
            return ["Test":AppBaseViewController.self]
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
    }
}
