//
//  HLHomeVC.swift
//  xiaohailang
//
//  Created by 刘达浮云 on 2019/2/26.
//  Copyright © 2019 刘达浮云. All rights reserved.
//

import UIKit

class HLHomeVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        
    }
   
    override func createUI() {
        super.createUI()
        self.addNavBtn()
        self.navRightBtn1.setTitle("搜索", for: UIControl.State.normal)
    }

    
    override func navRightBtnClick(btn: UIButton) {
        XLOG("我就不点击右侧按钮")
    }
    
    
}
