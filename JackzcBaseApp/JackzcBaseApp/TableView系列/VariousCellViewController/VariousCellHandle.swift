//
//  VariousCellProtocol.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/1.
//  Copyright © 2018年 silence. All rights reserved.
//

import Foundation
import UIKit

protocol VariousModelProtocol {
    /// 当标题是由过个字段组成时可使用
    var mixTitle:String {get}
}

protocol CellModel:VariousModelProtocol  {
    
}

protocol VariousCellProtocol {
    
    associatedtype DataType
    /// cell的标识符
    static var identify:String {get}
    /// 默认高度
    var estimatedHeight:CGFloat {get}
    /// cell对应的数据model
    ///
    /// - Parameter model: 数据对象
    /// - Returns: Void
    func cellConfigueInfo(model: DataType) -> Void
}

extension VariousCellProtocol{
   static var identify:String {
        get{
            return String(describing: Self.self)
        }
    }
}

protocol SectionViewProtocol {
    associatedtype SectionDataType
    associatedtype CellDataType
    
    /// collection的组视图用得上
    static var identify:String {get}
    /// 组视图高度
    var sectionHeight: CGFloat {get set}
    /// 组内cell数据
    var dataArray:[CellDataType] {get set}
    /// Section对应的数据model
    ///
    /// - Parameter model: 数据对象
    /// - Returns: Void
    func cellConfigueInfo(model: CellDataType) -> Void
}

protocol SectionHeadProtocol: SectionViewProtocol {
    
}

protocol SectionFootProtocol: SectionViewProtocol {
    
}

class SectionModel {
    var title:String = ""
}

class VariousCellModelDecorator{
    typealias CellModelDecorator = UITableView
}

