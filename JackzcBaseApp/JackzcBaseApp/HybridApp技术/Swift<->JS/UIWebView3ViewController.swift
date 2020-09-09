//
//  UIWebView3ViewController.swift
//  JackzcBaseApp
//
//  Created by zouchao on 2018/11/20.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit
import JavaScriptCore

class UIWebView3ViewController: AppBaseViewController {
    
    var jsContext:JSContext?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.showLabel)
        self.view.addSubview(self.webView)
        
        let url = Bundle.main.url(forResource: "index3.html", withExtension: nil)
        let request = NSURLRequest(url: url!)
        self.webView.loadRequest(request as URLRequest)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(rightItemAction))
    }
    
    lazy var webView: UIWebView = {
        let webView = UIWebView(frame: CGRect(x: 0, y: 124, width: AppWidth, height: AppHeight-124))
        webView.delegate = self
        return webView
    }()
    
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        return picker
    }()
    
    lazy var showLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 64+20, width: 100, height: 30))
        label.textColor = UIColor.orange
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "我是一个文本"
        return label
    }()
    
    @objc func rightItemAction() -> Void {
        guard let jsContext = self.jsContext else {
            return
        }
        jsContext.evaluateScript("jackzc()")
    }
    
    func removeSpaceAndLine(in string:String) -> String {
        var temp = string.replacingOccurrences(of: " ", with: "")
        temp = temp.replacingOccurrences(of: "\r", with: "")
        temp = temp.replacingOccurrences(of: "\n", with: "")
        return temp
    }
    
    func openAlbum() -> Void {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    deinit {
        print("\(self.title ?? "")销毁了")
    }

}

extension UIWebView3ViewController:UIWebViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let title = webView.stringByEvaluatingJavaScript(from: "document.title")
        self.title = title
        
        let context = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext")
        self.jsContext = context as? JSContext
        
        self.jsContext?.exceptionHandler = { (context, exception) in
            print("发生了异常===\(String(describing: exception))")
        }
        
        let bridgeObj = BridgeObject()
        self.jsContext?.setObject(bridgeObj, forKeyedSubscript: "bridgeObj" as NSCopying & NSObjectProtocol)
        
        //let jsValue: @convention(block) ()->Void
        let getImage:@convention(block) ()->Void = { [weak self] in
            self?.openAlbum()
        }
        self.jsContext?.setObject(getImage, forKeyedSubscript: "getImage" as NSCopying & NSObjectProtocol)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let resultImage = info["UIImagePickerControllerEditedImage"]
        let imageData = UIImageJPEGRepresentation(resultImage as! UIImage, 0.01)
        let encodedImageStr = imageData?.base64EncodedString(options: .lineLength64Characters)
        picker.dismiss(animated: true, completion: nil)
        
        let imageString = self.removeSpaceAndLine(in: encodedImageStr ?? "")
        let jsFuncStr = "showImage('\(imageString)')"
        self.jsContext?.evaluateScript(jsFuncStr)
    }
    
}

//不要忘记声明成@objc
@objc protocol BrideObjectProtocol:JSExport {
    func letShowImage() -> Void
    //传参时注意命名规范必须在参数前加_
    func getSum(_ m:Int,_ n:Int) -> Int
}

//不要忘记声明成@objc
@objc class BridgeObject: NSObject,BrideObjectProtocol {
    func letShowImage() {
        print("打开相册")
    }
    func getSum(_ m:Int,_ n:Int) -> Int {
        return m+n
    }
}
