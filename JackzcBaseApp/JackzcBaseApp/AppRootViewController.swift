//
//  AppRootViewController.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/1.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit
import SnapKit

protocol JackzcViewControllerProtocol {
    
}

extension UIViewController:JackzcViewControllerProtocol{
    
}

class AppRootViewController: AppBaseViewController {
    
    var AppDic:[String: UIViewController.Type] = ["TableView系列":TableRootViewController.self,
                                                  "Test":UIViewController.self,
                                                  ]
    var tableArray:[String]{
        get{
            return self.AppDic.keys.reversed()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "JackzcBase"
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { (maker) in
              maker.edges.equalToSuperview()
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "rootBaseCellID")
        return tableView
    }()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension AppRootViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rootBaseCellID")
        cell?.selectionStyle = .none
        cell?.textLabel?.text = self.tableArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let classType = self.AppDic[self.tableArray[indexPath.row]]
        if let className = classType {
            let vc = className.init()
            let navigationVC = AppBaseNavigationController(rootViewController: vc)
            App.keyWindow?.rootViewController = navigationVC
        };
    }
}
