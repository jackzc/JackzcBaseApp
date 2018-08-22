
//
//  MVVMViewController.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/16.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

class MVVMViewController: AppBaseViewController {
    
    var tableArray:[MVModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MVVM模式"
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    
        let viewModel = MVViewModel()
        viewModel.loadData(){ [unowned self] dataArray in
            let row =  dataArray.count / 4
            let headView = MVView(frame: CGRect(x: 0, y: 0, width: AppWidth, height: CGFloat(row) * 50.0))
            headView.createAndAddView(with: dataArray)
            self.tableView.tableHeaderView = headView
            self.tableArray = dataArray
            self.tableView.reloadData()
        }
        
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MVTableViewCell.self, forCellReuseIdentifier: "MVTableViewCell")
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = 0.01
        return tableView
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MVVMViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MVTableViewCell") as! MVTableViewCell
        cell.moduleButton.setTitle(self.tableArray[indexPath.row].title, for: .normal)
        cell.moduleButton.backgroundColor = self.tableArray[indexPath.row].color
        return cell
    }
}
