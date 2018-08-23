

//
//  DesignPatternRootViewController.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/23.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

class DesignPatternRootViewController: AppBaseRootViewController {
    
    override var vcTitle: String{
        set{}
        get{
            return "设计模式"
        }
    }
    override var AppDic: [String : AppBaseViewController.Type]{
        set{}
        get{
            return ["模板模式":TemplatePatternViewController.self]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
