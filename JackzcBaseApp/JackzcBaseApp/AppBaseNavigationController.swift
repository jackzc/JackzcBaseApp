//
//  AppBaseNavigationController.swift
//  JackzcBaseApp
//
//  Created by silence on 2018/8/1.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

class AppBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func backAction() -> Void {
        JackzcAppDelegate.window?.rootViewController = JackzcAppDelegate.baseRootVC
    }

}

extension AppBaseNavigationController:UINavigationControllerDelegate{
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool){
        guard self.viewControllers.count == 1 else {
            return
        }
       viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backAction))
    }
}
