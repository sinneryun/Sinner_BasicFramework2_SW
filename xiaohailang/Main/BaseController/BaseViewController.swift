//
//  BaseViewController.swift
//  xiaohailang
//
//  Created by 刘达浮云 on 2019/2/18.
//  Copyright © 2019 刘达浮云. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // NavBar右侧第一个按钮
    let navRightBtn1 = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    // NavBar右侧第二个按钮
    let navRightBtn2 = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UMengTools.GoIn(ViewTitle: ClassName)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UMengTools.GoOut(ViewTitle: ClassName)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange
        
        self.crUI()
        self.createUI()
        
        
    }
    
    //创建UI
    func createUI() {
    }
    
    
    func crUI() {
        
        var frame = CGRect(x: 0, y: 0, width: HL_APP_WIDTH, height: HL_APP_HEIGHT - HL_TOP_HEIGHT - HL_TABBAR_HEIGHT)
        if navigationController?.navigationBar.isHidden == true{
            frame.size.height += HL_TOP_HEIGHT
        }
        if hidesBottomBarWhenPushed == true {
            frame.size.height += HL_TABBAR_HEIGHT
        }
        
        view.frame = frame
        
        
    }
    
    
    // Nav单个右侧按钮
    func addNavBtn() {
        
        navRightBtn1.setTitleColor(UIColor.black, for: UIControl.State.normal)
        navRightBtn1.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        navRightBtn1.addTarget(self, action: #selector(navRightBtnClick(btn:)), for: UIControl.Event.touchUpInside)
        let item=UIBarButtonItem(customView: navRightBtn1)
        self.navigationItem.rightBarButtonItem = item
    }
    // Nav两个右侧按钮
    func addNavBtns() {
        
        navRightBtn1.setTitleColor(UIColor.black, for: UIControl.State.normal)
        navRightBtn1.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        navRightBtn1.addTarget(self, action: #selector(navRightBtnClick(btn:)), for: UIControl.Event.touchUpInside)
        let items1=UIBarButtonItem(customView: navRightBtn1)
        
        navRightBtn2.setTitleColor(UIColor.black, for: UIControl.State.normal)
        navRightBtn2.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        navRightBtn2.addTarget(self, action: #selector(navRightBtnClick(btn:)), for: UIControl.Event.touchUpInside)
        let items2=UIBarButtonItem(customView: navRightBtn2)
        
        self.navigationItem.rightBarButtonItems = [items1,items2]
    }
    
    // Nav按钮事件
    @objc func navRightBtnClick(btn: UIButton) {
    }
    
    
    
    var ClassName:String{
        get{
            let name =  type(of: self).description()
            if(name.contains(".")){
                return name.components(separatedBy: ".")[1];
            }else{
                return name;
            }
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    deinit {
        XLOG("--- [\(ClassName)] -- <\(self.title!)> -- 已销毁")
    }
    

}
