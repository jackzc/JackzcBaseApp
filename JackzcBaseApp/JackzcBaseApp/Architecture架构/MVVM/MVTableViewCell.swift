

//
//  MVTableViewCell.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/20.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

class MVTableViewCell: UITableViewCell {

    lazy var moduleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("MVVM", for: .normal)
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(moduleButton)
        moduleButton.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(20)
            maker.top.equalToSuperview().offset(10)
            maker.bottom.equalToSuperview().offset(-10)
            maker.width.equalTo(100)
            let height =  maker.height.equalTo(30).constraint
            height.layoutConstraints.first?.priority = UILayoutPriority.defaultLow
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
