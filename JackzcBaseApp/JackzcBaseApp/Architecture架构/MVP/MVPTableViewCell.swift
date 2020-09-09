

//
//  MVPTableViewCell.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/16.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

protocol MVPTableViewCellDelegate:NSObjectProtocol {
    func didAddItem() -> Void
}

class MVPTableViewCell: UITableViewCell {
    
    var indexPath:IndexPath?
    weak var delegate:MVPTableViewCellDelegate?

    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.red
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.green
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton(type: UIButtonType.contactAdd)
        button.addTarget(self, action: #selector(addAction(button:)), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(descLabel)
        self.contentView.addSubview(addButton)
        
        contentLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(20)
            maker.centerY.equalToSuperview()
            
        }
        
        descLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(contentLabel.snp.left)
            maker.bottom.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().offset(-20)
        }
    }
    
    @objc func addAction(button: UIButton) -> Void {
        self.delegate?.didAddItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
