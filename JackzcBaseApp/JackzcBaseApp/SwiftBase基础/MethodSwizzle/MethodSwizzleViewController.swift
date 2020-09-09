//
//  MethodSwizzleViewController.swift
//  JackzcBaseApp
//
//  Created by zouchao on 2018/12/21.
//  Copyright © 2018年 silence. All rights reserved.
//

import UIKit

class TestSwizzling:NSObject {
    @objc dynamic func methodOne() -> Int{
        return 1
    }
}

extension TestSwizzling {
    
}

class MethodSwizzleViewController: AppBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
