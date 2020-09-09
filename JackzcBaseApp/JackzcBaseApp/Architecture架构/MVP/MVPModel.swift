

//
//  MVPModel.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/16.
//  Copyright © 2018年 silence. All rights reserved.
//

import Foundation


class MVPModel {
    var content:String
    var desc:String
    var number:Int
    init(content:String, desc:String, number: Int) {
        self.content = content
        self.desc = desc
        self.number = number
    }
}
