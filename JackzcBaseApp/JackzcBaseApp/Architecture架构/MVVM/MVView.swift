

//
//  MVView.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/20.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

class MVView: UIView {

    func createAndAddView(with data:[MVModel]) -> Void {
        let count = data.count
        guard count > 0 else {
            return
        }
        
        let btnWd:CGFloat = AppWidth/4.0
        let btnHg:CGFloat = 50.0
        for index in 0 ..< count{
            
            let row = index / 4
            let col = index % 4
            
            let btnX = CGFloat(col) * btnWd
            let btnY = CGFloat(row) * btnHg
            
            let btn = UIButton(type: .custom)
            btn.setTitle(data[index].title, for: .normal)
            btn.backgroundColor = data[index].color
            btn.frame = CGRect(x: btnX, y: btnY, width: btnWd, height: btnHg)
            btn.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
            self.addSubview(btn)
        }
    }

    @objc func buttonAction(button:UIButton) -> Void {
        
    }
    
}

extension MVView{
    
    class func createImage(with color:UIColor) -> UIImage?{
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


