
//
//  UITableView+Extension.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/24.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// 注册cell的快捷方式，默认cell的Id与类名字符串是完全一致的
    ///
    /// - Parameter cellClass: cell的类对象
    func registerCell(_ cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    /// 注册cell的快捷方式，默认cell的Id与类名字符串是完全一致的
    ///
    /// - Parameter cellClass: cell的类对象
    func registerNibCell(_ cellClass: AnyClass) {
        register(UINib(nibName: String(describing: cellClass), bundle: Bundle(for: cellClass)), forCellReuseIdentifier: String(describing: cellClass))
    }
}

extension UITableView{
    
    /// 自动布局tableViewHead
    ///
    /// - Parameter headView: UIView视图
    func setAndLayoutTableViewHeaderView(_ headView: UIView?) -> Void {
        guard let tableHeadView = headView else {
            self.tableHeaderView = headView
            return
        }
        tableHeadView.setNeedsLayout()
        tableHeadView.layoutIfNeeded()
        var frame = tableHeadView.frame
        let size = tableHeadView.systemLayoutSizeFitting(UILayoutFittingExpandedSize)
        frame.size = size
        tableHeadView.frame = frame
        self.tableHeaderView = tableHeadView
    }
    
    /// 自动布局tableViewFoot
    ///
    /// - Parameter footView: UIView视图
    func setAndLayoutTableViewFootView(_ footView: UIView?) -> Void {
        guard let tableFootView = footView else {
            self.tableFooterView = footView
            return
        }
        tableFootView.setNeedsLayout()
        tableFootView.layoutIfNeeded()
        var frame = tableFootView.frame
        let size = tableFootView.systemLayoutSizeFitting(UILayoutFittingExpandedSize)
        frame.size = size
        tableFootView.frame = frame
        self.tableFooterView = tableFootView
    }
}
