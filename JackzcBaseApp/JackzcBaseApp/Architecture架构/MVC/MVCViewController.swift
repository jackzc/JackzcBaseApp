

//
//  MVCViewController.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/16.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

class MVCViewController: AppBaseViewController {
    
    var dataArray:[MVCModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MVC模式"
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        self.loadData()
        self.tableView.reloadData()
    }
    
    func loadData() -> Void {
        self.dataArray.removeAll()
        let array = ["南美洲","大洋洲","北美洲","亚洲","欧洲","非洲","南极洲"]
        for content in array {
            let model = MVCModel(content: content)
            self.dataArray.append(model)
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MVCViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify = "mvccell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identify) as? MVCTableViewCell
        if cell == nil {
            cell = MVCTableViewCell(style: .default, reuseIdentifier: identify)
        }
        cell?.contentLabel.text = self.dataArray[indexPath.row].content
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
