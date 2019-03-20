//
//  GlobalDefine.swift
//  xiaohailang
//
//  Created by 刘达浮云 on 2019/2/18.
//  Copyright © 2019 刘达浮云. All rights reserved.
//

import UIKit
import Foundation

//@_exported import Kingfisher

// MARK:- 颜色方法
//rgb颜色
func HL_RGB (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
//16进制颜色
func HL_HEXCOLOR (_ hexValue: Int) -> UIColor {
    return UIColor.hexInt(hexValue)
}

let HL_BG_COLOR = HL_HEXCOLOR(0xf9f9f9)

// 当前系统版本
let HL_VERSION = (UIDevice.current.systemVersion as NSString).floatValue
// 屏幕宽度
let HL_APP_WIDTH = UIScreen.main.bounds.width
// 屏幕高度
let HL_APP_HEIGHT = UIScreen.main.bounds.height


//状态栏高度
let HL_STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height
//导航条高度
let HL_NAVBAR_HEIGHT = CGFloat(44.0)
//底部tabbar高度
let HL_TABBAR_HEIGHT = CGFloat((HL_STATUSBAR_HEIGHT > 20) ? 83 : 49)
//整个顶部的高度
let HL_TOP_HEIGHT = (HL_STATUSBAR_HEIGHT + HL_NAVBAR_HEIGHT)


// MARK:- 自定义打印方法
func XLOG<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
    
    let fileName = (file as NSString).lastPathComponent
    
    print("\(fileName):(\(lineNum))-\(message)")
    
    #endif
}

// MARK:- 获取当前展示ViewContrller
func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let nav = base as? UINavigationController {
        return currentViewController(base: nav.visibleViewController)
    }
    if let tab = base as? UITabBarController {
        return currentViewController(base: tab.selectedViewController)
    }
    if let presented = base?.presentedViewController {
        return currentViewController(base: presented)
    }
    return base
}
