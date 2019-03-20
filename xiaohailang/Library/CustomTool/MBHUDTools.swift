//
//  HUDTools.swift
//  smallCrowdStar
//
//  Created by 刘达浮云 on 2018/5/24.
//  Copyright © 2018年 ty4wd. All rights reserved.
//

import Foundation
import UIKit

class HUDTools: NSObject {
    
    
    /**
     可带文字的菊花
     */
    class func showWait(_ Text: String?){
        let  showView = viewToShow()
        let hud = MBProgressHUD.showAdded(to: showView, animated: true)
        hud.label.text = Text
        hud.removeFromSuperViewOnHide = true
    }
    
    /**
     闪现1秒钟的文字
     */
    @objc class func showMoment(_ Text: String?){
        let  showView = viewToShow()
        let hud = MBProgressHUD.showAdded(to: showView, animated: true)
        hud.mode = .text
        hud.label.text = Text
        hud.label.numberOfLines = 0
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示0.5秒后自动隐藏
        hud.hide(animated: true, afterDelay: 1)
    }
    
    /**
     可带文字的进度圈
     */
    class func showProgressRound(_ Text: String?, _ Progress: Float){
        let  showView = viewToShow()
        let hud = MBProgressHUD.showAdded(to: showView, animated: true)
        hud.mode = .determinate
        hud.label.text = Text
        hud.removeFromSuperViewOnHide = true
        hud.progress = Progress
        
        if hud.progress == 1 {
            close()
        }
    }
    
    /**
     可带文字的进度条
     */
    @objc class func showProgressStrips(_ Text: String?, _ Progress: Float){
        let  showView = viewToShow()
        let hud = MBProgressHUD.showAdded(to: showView, animated: true)
        hud.mode = .determinateHorizontalBar
        hud.label.text = Text
        hud.removeFromSuperViewOnHide = true
        hud.progress = Progress
        
        if hud.progress == 1 {
            close()
        }
    }
    
    /**
     关闭HUD
     */
    @objc class func close() {
        let  showView = viewToShow()
        MBProgressHUD.hide(for: showView, animated: true)
    }
    
    
    ///获取用于显示提示框的view
    class func viewToShow() -> UIView {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            let windowArray = UIApplication.shared.windows
            for tempWin in windowArray {
                if tempWin.windowLevel == UIWindow.Level.normal {
                    window = tempWin;
                    break
                }
            }
        }
        return window!
    }
}
