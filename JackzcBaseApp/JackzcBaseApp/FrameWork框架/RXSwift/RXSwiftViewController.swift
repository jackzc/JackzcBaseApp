
//
//  RXSwiftViewController.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/16.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RXSwiftViewController: AppBaseViewController {
    
    var tableArray:[StudentModel] = []
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "RXSwift"
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
        
        self.tableArray = [ StudentModel(name: "jack", age: 10),
                            StudentModel(name: "lily", age: 11),
                            StudentModel(name: "lucy ", age: 12),
                            StudentModel(name: "james", age: 13),
                            StudentModel(name: "Tom", age: 14),
                            StudentModel(name: "herry", age: 15),
                            StudentModel(name: "lucas", age: 16),
                            StudentModel(name: "bluse", age: 17),
                            StudentModel(name: "waden", age: 18)]
        
        let tableArray = Observable.just([StudentModel(name: "jack", age: 10),
                                          StudentModel(name: "lily", age: 11),
                                          StudentModel(name: "lucy ", age: 12),
                                          StudentModel(name: "james", age: 13),
                                          StudentModel(name: "Tom", age: 14),
                                          StudentModel(name: "herry", age: 15),
                                          StudentModel(name: "lucas", age: 16),
                                          StudentModel(name: "bluse", age: 17),
                                          StudentModel(name: "waden", age: 18)])
        
        tableArray.bind(to: tableView.rx.items(cellIdentifier: "rootBaseCellID")){
            (row, model, cell) in
            
            cell.textLabel?.text = model.description
        }.disposed(by: dispose)
        
        tableView.rx.modelSelected(StudentModel.self).subscribe { (model) in
            print("点击了\(String(describing: model.element?.description))")
        }.disposed(by: dispose)
    }
    
    func base() -> Void {
        let myob = Observable<Any>.create { (observer) -> Disposable in
            observer.onNext("computer")
            
            return Disposables.create()
        }
        
        myob.subscribe { (event) in
            print(event)
        }
    }
    
    func subject() -> Void {
        let subject = PublishSubject<String>()
        subject.onNext("大吉大利")
//        subject.onError()
        
        subject.subscribe(onNext: { (str) in
            
        }, onError: { (error) in
            
        }, onCompleted: {
            
        }) {
            
        }
    }
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "rootBaseCellID")
        return tableView
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

struct StudentModel {
    var name:String
    var age:Int
    init(name:String, age:Int) {
        self.name = name
        self.age = age
    }
}

extension StudentModel:CustomStringConvertible{
    var description: String {
        return "name == \(self.name) age == \(self.age)"
    }
}
