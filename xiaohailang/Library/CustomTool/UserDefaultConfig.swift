//
//  ViewController.swift
//  xiaohailang
//
//  Created by 刘达浮云 on 2019/2/14.
//  Copyright © 2019 刘达浮云. All rights reserved.
//

import UIKit

struct UserDefaultKeys {
    // 账户信息
    struct AccountInfo {
        static let uid = "uid"
        static let clientId = "clientId"
        
    }
    
    // 登录信息
    struct LoginInfo {
        static let token = "token"
        static let refreshTime = "refreshTime"
    }
    
    // 配置信息
    struct SettingInfo {
        
    }
    
    // 历史搜索
    struct SearchInfo {
        static let searchHistory = "searchHistory"
    }
}

