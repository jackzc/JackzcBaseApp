//
//  UIWebViewViewController.swift
//  JackzcBaseApp
//
//  Created by zouchao on 2018/11/20.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

class UIWebViewViewController: AppBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.webView)
        
        let url = Bundle.main.url(forResource: "index.html", withExtension: nil)
        let request = NSURLRequest(url: url!)
        self.webView.loadRequest(request as URLRequest)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAction))
    }
    
    lazy var webView: UIWebView = {
        let webView = UIWebView(frame: self.view.bounds)
        webView.delegate = self
        return webView
    }()
    
    @objc func editAction() -> Void {
        let result = self.webView.stringByEvaluatingJavaScript(from: "showAlert('HELLO')()")
        print(result ?? "")
    }
    
    @objc func getSum()->Void{
        let result = self.webView.stringByEvaluatingJavaScript(from: "showAlert('Jackzc')()")
        print("获得结果 \(result ?? "")")
    }
    
    deinit {
        print("销毁了")
    }

}

extension UIWebViewViewController:UIWebViewDelegate{
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
         let title = webView.stringByEvaluatingJavaScript(from: "document.title")
         self.title = title
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        print(request.url?.scheme ?? "")
        print(request.url?.host ?? "")
        print(request.url?.pathComponents ?? "")
        
        let scheme = request.url?.scheme ?? ""
        if scheme == "jackzc" {
            print("处理自定义协议")
            let args = request.url?.pathComponents
            guard let variables = args, variables.count > 1 else{
                return false
            }
            let methodName = variables[1]
            let methodSel = Selector(methodName)
            print(methodSel)
            //此时方法前必须加上@objc
            if self.responds(to: methodSel) {
                self.perform(methodSel)
            }
            return false
        }
        return true
    }
}


