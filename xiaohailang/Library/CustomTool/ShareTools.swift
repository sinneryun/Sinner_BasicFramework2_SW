//
//  ShareTools.swift
//  xiaohailang
//
//  Created by 刘达浮云 on 2019/3/4.
//  Copyright © 2019 刘达浮云. All rights reserved.
//

import UIKit

class ShareTools: NSObject {

    /**
     分享到 微信 / 朋友圈 / QQ / 新浪微博
     */
    class func share(shareTitle: String, shareText: String, shareImg: String, shareUrlStr: String, shareType: SSDKContentType) {

        let params = NSMutableDictionary()
        let shareUrl = URL(string: shareUrlStr)

        params.ssdkSetupShareParams(byText: shareText,
                                    images: shareImg,
                                    url: shareUrl,
                                    title: shareTitle,
                                    type: shareType)

        let config = SSUIShareSheetConfiguration()
        config.isCancelButtonHidden = true
        
        let shareList = [SSDKPlatformType.subTypeWechatSession.rawValue, SSDKPlatformType.subTypeWechatTimeline.rawValue, SSDKPlatformType.subTypeQQFriend.rawValue, SSDKPlatformType.typeSinaWeibo.rawValue]
        
        ShareSDK.showShareActionSheet(nil,
                                      customItems: shareList,
                                      shareParams: params,
                                      sheetConfiguration: config) { (state, platformType, userData, contentEntity, error, end) in

                                        switch state {
                                        case .success:
                                            XLOG("分享成功")
                                        case .fail:
                                            XLOG("分享失败:\(String(describing: error))" )
                                        case .cancel:
                                            XLOG("取消")
                                        default : break
                                        }

        }
        
    }
    
    
    
}
