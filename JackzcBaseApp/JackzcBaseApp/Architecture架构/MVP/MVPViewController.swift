
//
//  MVPViewController.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/16.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

class MVPViewController: AppBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MVP模式"
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        present.refreshData()
//        dataSource.dataArray.append(contentsOf: present.dataArray)
        dataSource.dataArray = present.dataArray
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MVPTableViewCell.self, forCellReuseIdentifier: "MVPCellId")
        return tableView
    }()
    
    lazy var present: MVPPresent = {
        let present = MVPPresent()
        return present
    }()
    
    lazy var dataSource: MVPDataSource = {
        let dataSource = MVPDataSource(identify: "MVPCellId", configureBlock: { [weak self] (cell, model, indexPath) in
            guard let `self` = self else{
                return
            }
            if let mvpCell = cell as? MVPTableViewCell {
                mvpCell.delegate = self.present
                mvpCell.contentLabel.text = model.content
                mvpCell.descLabel.text = model.desc
            }
        })
        return dataSource
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


