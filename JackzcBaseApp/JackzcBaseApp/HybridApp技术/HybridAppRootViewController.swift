
//
//  HybridAppRootViewController.swift
//  JackzcBaseApp
//
//  Created by zouchao on 2018/11/17.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

class HybridAppRootViewController: AppBaseRootViewController {

    override var vcTitle: String{
        set{}
        get{
            return "混合模式开发"
        }
    }
    
    override var AppDic: [String : AppBaseViewController.Type]{
        set{}
        get{
            return ["1.1.UIWebView<->JS(通过接口交互)":UIWebViewViewController.self,
                    "1.2.UIWebView<->JS(通过JScriptCore)":UIWebView2ViewController.self,
                    "1.3.深入JScriptCore":UIWebView3ViewController.self,
                    "2.ReactNative":AppBaseViewController.self,
                    "3.Flutter":AppBaseViewController.self,
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

        // Do any additional setup after loading the view.
    }

}
