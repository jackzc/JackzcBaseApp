//
//  MVPPresent.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/16.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit



class MVPPresent: NSObject {
    
    var dataArray:[MVPModel] = []
    
    func loadData() -> Void{
        
    }
    
    func refreshData() -> Void {
        self.dataArray.removeAll()
        let array = ["南美洲","大洋洲","北美洲","亚洲","欧洲","非洲","南极洲"]
        for i  in 0...6 {
            let title = array[i]
            let offSet = title.count - 1
            let endIndex = title.index(title.startIndex, offsetBy: offSet)
            let desc = "所在地:" + title[title.startIndex ..< endIndex]
            let model = MVPModel(content: title, desc: desc, number: i)
            self.dataArray.append(model)
        }
    }
    
    func loadMoreData() -> Void {
        
    }
    
}

extension MVPPresent: MVPTableViewCellDelegate{
    func didAddItem() {
        
    }
}
