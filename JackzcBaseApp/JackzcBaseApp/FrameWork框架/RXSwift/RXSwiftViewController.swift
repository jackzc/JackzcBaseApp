
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
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "RXSwift"
        
//        self.testObservable()
//        self.testObservable1()
        getRepo("").subscribe(onSuccess: { json in
            print("JOSN", json)
        },onError: { (error) in
            print("Error: ", error)
        }).disposed(by: disposeBag)
            
//        let rxData: Observable<Data>
//        rxData.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
//            .observeOn(MainScheduler.instance)
//            .subscribe({ data in
//
//            }).disposed(by: disposeBag)
        
       ///==============
//        self.textRXForTableView()
//        self.testAsynvSubject()
//        self.testPublisSubject()
//        self.testReplaySubject()
//        self.testBehaviorSubject()
//        self.testVariable()
        
        ///==============
        self.test_filter()
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "rootBaseCellID")
        return tableView
    }()
    
    lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        return textField;
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Observable - 可被监听的序列
extension RXSwiftViewController{
    
    //any
    func testObservable() -> Void {
        
        typealias JSON = Any
        let json:Observable<JSON> = Observable.create { (observer) -> Disposable in
            let task = URLSession.shared.dataTask(with: URL(fileURLWithPath: "https://www.douban.com/j/app/radio/channels"), completionHandler: { (data, reponse, error) in
                guard error == nil else{
                    observer.onError(error!)
                    return
                }
                
//                guard let data = data, let jsonObject = JSONSerialization.jsonObject(with: data, options: .mutableContainers) else{
//                    observer.onError(RxError.unknown)
//                    return
//                }
            })
            return Disposables.create()
        }
    }
    
    //Single
    func getRepo(_ repo: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create { single in
            let url = URL(string: "https://api.github.com/repos/\(repo)")!
            let task = URLSession.shared.dataTask(with: url){
                data, _, error in
                if let error = error {
                    single(.error(error))
                    return
                }
                guard let data = data,
                     let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                     let result = json as? [String: Any] else{
//                        single(.error(error))
                     return
                }
                single(.success(result))
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    //Int
    func testObservable1() -> Void {
        let numbers: Observable<Int> = Observable.create { (observer) -> Disposable in
            observer.onNext(0)
            observer.onNext(1)
            observer.onCompleted()
            return Disposables.create()
        }
        
        numbers.subscribe(onNext:{ element in
            print("obsevable For Int \(element)")
        }).disposed(by: disposeBag)
    }
}

// MARK: - Observable & Observer
// MARK: - 既是可被监听的序列也是观察者
extension RXSwiftViewController{
    
    /// 订阅后，发送最后一个
    func testAsynvSubject() -> Void {
        let disposeBag = DisposeBag()
        let subject = AsyncSubject<String>()
        subject.subscribe {
                print("Subscription: 1 Event:", $0)
               }.disposed(by: disposeBag)
        
        subject.onNext("🐱")
        subject.onNext("🐶")
        subject.onNext("🐭")
        subject.onCompleted()
    }
    
    /// 订阅后，发送之后的
    func testPublisSubject() -> Void {
        let disposeBag = DisposeBag()
        let subject = PublishSubject<String>()
        
        subject.subscribe {
            print("Subscription: 1 Event:", $0)
            }.disposed(by: disposeBag)
        subject.onNext("🐶")
        subject.onNext("🐱")
        
//        subject.onError(RxError.overflow)
        
        subject.subscribe {
            print("Subscription: 2 Event:", $0)
            }.disposed(by: disposeBag)
        subject.onNext("🌺")
        subject.onNext("⚽️")
    }
    
    /// 订阅后，发送全部
    func testReplaySubject() -> Void {
        let disposeBag = DisposeBag()
        let subject = ReplaySubject<String>.create(bufferSize: 1)
        
        subject.subscribe {
            print("Subscription: 1 Event:",$0)
        }.disposed(by: disposeBag)
        subject.onNext("🐶")
        subject.onNext("🐱")
        
        subject.subscribe {
            print("Subscription: 2 Event:",$0)
        }.disposed(by: disposeBag)
        subject.onNext("🌶")
        subject.onNext("🍆")
    }
    
    ///订阅后，把最新的发送出来
    func testBehaviorSubject() -> Void {
        let disposeBag = DisposeBag()
        let subject = BehaviorSubject(value: "🌞")
        
        subject.subscribe {
            print("Subscription: 1 Event:", $0)
        }.disposed(by: disposeBag)
        subject.onNext("🐶")
        subject.onNext("🐱")
        
        subject.subscribe {
            print("Subscription: 2 Event:", $0)
        }.disposed(by: disposeBag)
        
        subject.onNext("🍎")
        subject.onNext("🍌")
        
        subject.subscribe {
            print("Subscription: 3 Event:", $0)
            }.disposed(by: disposeBag)
        
        subject.onNext("🇨🇳")
        subject.onNext("🇺🇸")
    }
    
    /// Variable 封装了一个 BehaviorSubject，所以它会持有当前值，
    /// 并且 Variable 会对新的观察者发送当前值。
    func testVariable() -> Void {
        let model = Variable<StudentModel?>(nil)
        model.asObservable().subscribe({ model in
            //更新UI
        }).disposed(by: disposeBag)
        model.value = StudentModel(name: "木暮公延", age: 16)
    }
    
}

// MARK: - Operator
// MARK: - 操作符
extension RXSwiftViewController{
    
    func test_filter() -> Void {
        let rxTemperature = Observable.just(35.0)
        rxTemperature.filter { (temperature) -> Bool in
             return temperature > 33.0
            }.subscribe( onNext: { temperature in
                print("高温：\(temperature)度")
            }).disposed(by: disposeBag)
    }
    
}

extension RXSwiftViewController{
    
    func textRXForTableView() -> Void {
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
            }.disposed(by: disposeBag)
        
        //        tableArray.bind(to: tableView.rx.items(cellIdentifier: <#T##String#>))
        
        tableView.rx.modelSelected(StudentModel.self).subscribe { (model) in
            print("点击了\(String(describing: model.element?.description))")
            }.disposed(by: disposeBag)
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
