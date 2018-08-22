
//
//  RXSwiftViewController.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/16.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RXSwiftViewController: AppBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

struct StudentModel {
    var name:String
    var age:Int
    init(name:String, age:Int) {
        self.name = name
        self.age = age
    }
    mutating func showName(name:String){
        self.name = name
    }
}

extension StudentModel:CustomStringConvertible{
    var description: String {
        return "name == \(self.name) age == \(self.age)"
    }
}
