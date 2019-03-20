//
//  NavController.swift
//  xiaohailang
//
//  Created by 刘达浮云 on 2019/2/18.
//  Copyright © 2019 刘达浮云. All rights reserved.
//

import UIKit

class NavController: UINavigationController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        
        navigationBar.barTintColor = UIColor.white
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = leftItem
        }
        super.pushViewController(viewController, animated: true)
    }
    
    lazy var leftItem: UIBarButtonItem = {
        let item = UIBarButtonItem(customView: backBtn)
        return item
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        btn.setImage(UIImage(named: "backGray"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 23)
        btn.addTarget(self, action: #selector(popView), for: .touchUpInside)
        return btn
    }()
    
    @objc func popView() {
        popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
