//
//  ViewModel.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/20.
//  Copyright © 2018年 silence. All rights reserved.
//

import Foundation
import UIKit

class MVViewModel: NSObject{
    
    var contentKey:String = ""
    var dataArray:[MVModel] = []
    
    override init() {
        super.init()
        self.addObserver(self, forKeyPath: "contentKey", options: .new, context: nil)
    }

    func loadData(complete:@escaping (_ dataArray:[MVModel])->Void) -> Void {
        DispatchQueue.global().async {
            
            self.dataArray.removeAll()
            let array = ["转账","信用卡","充值中心","蚂蚁借呗","电影票","滴滴出行","城市服务","蚂蚁森林"]
            for title in array{
                
                let random1 = CGFloat(arc4random() % 255) / 255.0
                let random2 = CGFloat(arc4random() % 255) / 255.0
                let random3 = CGFloat(arc4random() % 255) / 255.0
                let random4 = CGFloat(arc4random() % 255) / 255.0
                
                let randomColor = UIColor(red: CGFloat(random1), green: CGFloat(random2), blue: CGFloat(random3), alpha: CGFloat(random4))
                
                let model = MVModel(title: title, color: randomColor)
                self.dataArray.append(model)
            }
            
            DispatchQueue.main.sync {
                 complete(self.dataArray)
            }
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "contentKey")
    }
}


