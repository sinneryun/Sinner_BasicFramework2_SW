//
//  TabBarController.swift
//  xiaohailang
//
//  Created by 刘达浮云 on 2019/2/18.
//  Copyright © 2019 刘达浮云. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAllChildController()
        
    }
    
    func changeBarColor() {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: HL_APP_WIDTH, height: HL_TABBAR_HEIGHT))
        view.backgroundColor = UIColor.white
        tabBar.insertSubview(view, at: 0)
        tabBar.isOpaque = true
        
    }
    
    func createAllChildController(){
        setUpOneChildController(rootVC: HLHomeVC(), normalImgName: "同-nor", selectImgName: "同-sel", title: "首页")
        setUpOneChildController(rootVC: HLToolVC(), normalImgName: "砚-nor", selectImgName: "砚-sel", title: "工具")
        setUpOneChildController(rootVC: HLSelfVC(), normalImgName: "驱-nor", selectImgName: "驱-sel", title: "我的")
    }
    
    func setUpOneChildController(rootVC:UIViewController, normalImgName:String, selectImgName:String, title:String){
        
        let nvc = NavController(rootViewController: rootVC)
        nvc.tabBarItem.image = UIImage(named: normalImgName)?.withRenderingMode(.alwaysOriginal)
        nvc.tabBarItem.selectedImage = UIImage(named: selectImgName)?.withRenderingMode(.alwaysOriginal)
        nvc.tabBarItem.title = title
        nvc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: HL_RGB(r: 193, g: 193, b: 193, a: 1)], for: .normal)
        nvc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: HL_RGB(r: 56, g: 56, b: 56, a: 1)], for: .selected)
        
        addChild(nvc)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
