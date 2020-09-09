//
//  SwiftBaseRootViewController.swift
//  JackzcBaseApp
//
//  Created by zouchao on 2018/12/21.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

class SwiftBaseRootViewController: AppBaseRootViewController {

    override var vcTitle: String{
        set{}
        get{
            return "Swift技术点"
        }
    }
    
    override var AppDic: [String : AppBaseViewController.Type]{
        set{}
        get{
            return ["1.黑魔法在Swift中的实现":MethodSwizzleViewController.self,
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

}
