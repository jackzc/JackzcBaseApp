//
//  UIWebView2ViewController.swift
//  JackzcBaseApp
//
//  Created by zouchao on 2018/11/20.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit
import JavaScriptCore

class UIWebView2ViewController: AppBaseViewController {

    var jsContext:JSContext?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.webView)
        
        let url = Bundle.main.url(forResource: "index2.html", withExtension: nil)
        let request = NSURLRequest(url: url!)
        self.webView.loadRequest(request as URLRequest)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(rightItemAction))
    }
    
    lazy var webView: UIWebView = {
        let webView = UIWebView(frame: self.view.bounds)
        webView.delegate = self
        return webView
    }()
    
    @objc func rightItemAction() -> Void {
        guard let jsContext = self.jsContext else {
            return
        }
        //swift->js
        jsContext.evaluateScript("submit()")
    }
    deinit {
        print("\(self.title ?? "")销毁了")
    }

}

extension UIWebView2ViewController:UIWebViewDelegate{
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let title = webView.stringByEvaluatingJavaScript(from: "document.title")
        self.title = title
        
        //获取当前页面上下文JSContext
        let jsContext = self.webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext")
        self.jsContext = jsContext as? JSContext
        
        //捕获调用异常
        self.jsContext?.exceptionHandler = { context, exception in
            context?.exception = exception
            print("exception == \(String(describing: exception))")
            print("currentContext ==\(String(describing: context))")
        }
        
        //提供全局变量
        self.jsContext?.evaluateScript("var arr = ['jack','tom','lucy']")
        
        //js->swift
        //声明该block时一定要注意
        /*当使用 Objective-C 创建一个 block，然后将其赋值给 JSContext 之后，JavaScriptCore 会自动将改 block 转换为 js 代码中的 function 对象。这里注意，JavaScriptCore 只能识别 Objective-C 中的 block，所以当我们使用 Swift 代码时，需要使用 @convention 将 Swift 中的闭包转成 Objective-C 的 block
        */
        let jsValue: @convention(block) ()->Void = {
            let thisValue = JSContext.currentThis()
            print("thisValue == \(String(describing: thisValue))")
            let callValue = JSContext.currentCallee()
            print("callValue == \(String(describing: callValue))")
            let args = JSContext.currentArguments()
            print("args == \(String(describing: args))")
            
            let dictionary = ["name" : "kobe", "age": "24"]
            let calljsValue = JSContext.current()?.objectForKeyedSubscript("ocCalljs")
            calljsValue?.call(withArguments: [dictionary])
        }
        self.jsContext?.setObject(jsValue, forKeyedSubscript: "showMessage" as NSCopying & NSObjectProtocol)
    }
}

//JavaScriptCore 的使用及类的说明
//https://juejin.im/entry/59c0e144f265da066a102f91
/*
class CustomView: UIView {
    var context: JSContext?
    var handler: JSValue?
    init(handler: JSValue?, context: JSContext?) {
        super.init(frame: CGRect.zero)
        self.context = context
        self.handler = handler
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
        
    }
}
 其中存在循环引用 可使用其中这个方式解决https://juejin.im/entry/59c0e144f265da066a102f91
let demo: @convention(block) (JSValue?) -> Void = { handler in
    let context = JSContext.current()
    let customObject = CustomView(handler: handler, context: context)}context.setObject(demo, forKeyedSubscript: "customObject" as NSString
)
 */

/*
 JSExport
 如果我们想要在 js 代码中调用我们用 native 代码创建的自定义对象，只需要让其遵循 JSExport 协议，则会自动将协议中声明的属性、方法等提供给 js 代码来进行使用。如果我们是想在 js 代码中调用已经定义好的系统类或者某个第三方库的类，我们不太好去改这种类的源码，可以使用 runtime 中的 class_addProtocol 方法为该类动态添加该协议。
 
 比如我们写一个 Person 类，然后让 js 代码中来进行调用 Person 类中的方法：
 实现可参考http://www.mengyueping.com/2017/07/02/iOS-JSExport-JSCallOC-Swift/
@objc protocol PersonProtocol: JSExport {
    var name: String { get }
    func printName()
}

@objc class Person: NSObject, PersonProtocol {
    var name: String {
        return "iCell"
    }
    func printName() {
        print(self.name)
        
    }
    
}
let person = Person()
let context = JSContext.current()
context.setObject(person, forKeyedSubscript: "p" as NSString)
context.evaluateScript("p.printName()")
 */
