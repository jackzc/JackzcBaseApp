

//
//  Source.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/4.
//  Copyright © 2018年 silence. All rights reserved.
//

import Foundation
import UIKit

protocol Source {
//    associatedtype ViewType = Self
//    associatedtype ModelType = Self
}

extension UITableView:Source{
    
}

extension UITableViewCell:Source{
    
}

extension UIView:Source{
    
}

class TableSource: Source {

}

class SectionSource: Source {

    
}

class RowSource: Source<ModelType,ViewType>{
    
}

class SectionHeadSource: Source {
    
}

class SectionFootSource: Source {
    
}











