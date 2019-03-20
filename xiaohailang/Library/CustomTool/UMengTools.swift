//
//  UMengTools.swift
//  smallCrowdStar
//
//  Created by 营口港旅-iOS-云 on 2018/5/15.
//  Copyright © 2018年 ty4wd. All rights reserved.
//

import Foundation
import UIKit

class UMengTools: NSObject {
    
    
    /**
     进入页面
     */
    class func GoIn(ViewTitle: String?){
        MobClick.beginLogPageView(ViewTitle)
    }
    
    
    /**
     离开页面
     */
    class func GoOut(ViewTitle: String?){
        MobClick.endLogPageView(ViewTitle)
    }
    
    
    
    
}


