//
//  HLSelfVC.swift
//  xiaohailang
//
//  Created by 刘达浮云 on 2019/2/26.
//  Copyright © 2019 刘达浮云. All rights reserved.
//

import UIKit

class HLSelfVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        
    }
    
    
    override func createUI() {
        super.createUI()
        self.addNavBtns()
    }
    
    override func navRightBtnClick(btn: UIButton) {
        super.navRightBtnClick(btn: btn)
        if btn == self.navRightBtn1 {
            XLOG("按钮11111")
        } else {
            XLOG("按钮22222")
        }
    }

}
