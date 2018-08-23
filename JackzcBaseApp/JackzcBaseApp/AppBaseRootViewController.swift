



//
//  AppBaseRootViewController.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/23.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

protocol JackzcViewControllerProtocol {
     var vcTitle:String{get}
     var AppDic:[String: UIViewController.Type]{get}
     func titleForCurrentViewController() -> Void
     func tableDicForCurrentViewController() -> Void
}

class AppBaseRootViewController: AppBaseViewController {
    
    var vcTitle: String = "testVC"
    var AppDic: [String : AppBaseViewController.Type] = ["Test":AppBaseViewController.self]
    
    var tableArray:[String]{
        get{
            return self.AppDic.keys.reversed()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.vcTitle
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
    }
}

extension AppBaseRootViewController:UITableViewDelegate,UITableViewDataSource{
    
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
            vc.title = self.tableArray[indexPath.row]
            let navigationVC = AppBaseNavigationController(rootViewController: vc)
            App.keyWindow?.rootViewController = navigationVC
        };
    }
}
