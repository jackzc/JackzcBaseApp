//
//  MVPDataSource.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/17.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

typealias ConfigureBlock = (_ cell:UITableViewCell?, _ model:MVPModel , _ indexPath:IndexPath) -> Void

class MVPDataSource: NSObject {
    
    var dataArray:[MVPModel] = []
    var identify:String = ""
    var configureBlock: ConfigureBlock
    
    init(identify:String, configureBlock: @escaping ConfigureBlock) {
        self.identify = identify
        self.configureBlock = configureBlock
    }
    
}

extension MVPDataSource:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identify)
        self.configureBlock(cell, self.dataArray[indexPath.row], indexPath)
        return cell!
    }
}

