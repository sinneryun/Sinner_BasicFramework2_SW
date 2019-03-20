//
//  AppDelegate.swift
//  xiaohailang
//
//  Created by 刘达浮云 on 2019/2/14.
//  Copyright © 2019 刘达浮云. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GeTuiSdkDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tabBarVC = TabBarController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
        
        //配置
        self.appDelegateConfig()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
    /*         ***************************    华丽丽分割线    *****************************         */
    func appDelegateConfig() {
        
        /*  微信  */
        self.weChatRegister()
        
        /*  友盟统计  */
        self.UMAnalytics()
        
        /*  ShareSDK  */
        self.Share()
        
        /*  个推推送  */
        self.GeTuiAPNS()
        
    }
    
    
    
    // MARK:- 注册微信
    func weChatRegister() {
        //WXApi.registerApp("wxa9ee946447e34255")
    }
    
    // MARK:- 友盟统计
    func UMAnalytics(){
        UMConfigure.initWithAppkey(HL_UMeng_Key, channel: nil)
        MobClick.setScenarioType(eScenarioType(rawValue: 0)!)
        
        //获取测试机oid
        //let deviceID = UMConfigure.deviceIDForIntegration()
        //XLOG("友盟测试机oid:\(String(describing: deviceID))")
    }
    
    // MARK:- ShareSDK
    func Share() {
        ShareSDK.registPlatforms { register in
            register?.setupWeChat(withAppId: HL_WeChat_ID, appSecret: HL_WeChat_SECRET)
            register?.setupQQ(withAppId: HL_QQ_ID, appkey: HL_QQ_KEY)
            register?.setupSinaWeibo(withAppkey: HL_Sina_ID, appSecret: HL_Sina_SECRET, redirectUrl: "http://www.sharesdk.cn")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK:- 推送
    func GeTuiAPNS() {
        //        // [ GTSdk ]：是否运行电子围栏Lbs功能和是否SDK主动请求用户定位
        //        GeTuiSdk.lbsLocationEnable(true, andUserVerify: true);
        //
        //        // [ GTSdk ]：自定义渠道
        //        GeTuiSdk.setChannelId("XZXQ-iOS");
        
        // [ GTSdk ]：使用APPID/APPKEY/APPSECRENT启动个推
        GeTuiSdk.start(withAppId: HL_GT_ID, appKey: HL_GT_KEY, appSecret: HL_GT_SECRET, delegate: self);
        
        // 注册APNs - custom method - 开发者自定义的方法
        self.registerRemoteNotification();
        
        //        // 注册VOIP
        //        self.voipRegistration();
    }
    
    // MARK: 用户通知(推送) _自定义方法
    /** 注册用户通知(推送) */
    func registerRemoteNotification() {
        /*
         警告：Xcode8的需要手动开启“TARGETS -> Capabilities -> Push Notifications”
         */
        
        /*
         警告：该方法需要开发者自定义，以下代码根据APP支持的iOS系统不同，代码可以对应修改。
         以下为演示代码，仅供参考，详细说明请参考苹果开发者文档，注意根据实际需要修改，注意测试支持的iOS系统都能获取到DeviceToken。
         */
        
        let systemVer = (UIDevice.current.systemVersion as NSString).floatValue;
        if systemVer >= 10.0 {
            if #available(iOS 10.0, *) {
                let center: UNUserNotificationCenter = UNUserNotificationCenter.current()
                center.delegate = self;
                center.requestAuthorization(options: [.alert,.badge,.sound], completionHandler: { (granted:Bool, error:Error?) -> Void in
                    if (granted) {
                        print("注册通知成功") //点击允许
                    } else {
                        print("注册通知失败") //点击不允许
                    }
                })

                UIApplication.shared.registerForRemoteNotifications()
            } else {
                    let userSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
                    UIApplication.shared.registerUserNotificationSettings(userSettings)

                    UIApplication.shared.registerForRemoteNotifications()
            };
        }else if systemVer >= 8.0 {
            if #available(iOS 8.0, *) {
                let userSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(userSettings)

                UIApplication.shared.registerForRemoteNotifications()
            }
        }else {
            if #available(iOS 7.0, *) {
                UIApplication.shared.registerForRemoteNotifications(matching: [.alert, .sound, .badge])
            }
        }
        
    }
    
    // MARK: 远程通知(推送)回调
    /** 远程通知注册成功委托 */
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceToken_ns = NSData.init(data: deviceToken);    // 转换成NSData类型
        var token = deviceToken_ns.description.trimmingCharacters(in: CharacterSet(charactersIn: "<>"));
        token = token.replacingOccurrences(of: " ", with: "")
        
        // [ GTSdk ]：向个推服务器注册deviceToken
        GeTuiSdk.registerDeviceToken(token);
        XLOG("\n\n[DeviceToken Success] === \(token) \n\n")
    }
    
    /** 远程通知注册失败委托 */
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        XLOG("\n\n[DeviceToken Error] === \(error.localizedDescription) \n\n");
    }
    
    // MARK: APP运行中接收到通知(推送)处理 - iOS 10 以下
    /** APP已经接收到“远程”通知(推送) - (App运行在后台) */
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        application.applicationIconBadgeNumber = 0;        // 标签
        
        XLOG("\n\n[Receive RemoteNotification] === \(userInfo) \n\n");
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // [ GTSdk ]：将收到的APNs信息传给个推统计
        GeTuiSdk.handleRemoteNotification(userInfo);
        
        XLOG("\n\n[Receive RemoteNotification] === \(userInfo) \n\n");
        
        completionHandler(UIBackgroundFetchResult.newData);
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        XLOG("\n\n[willPresentNotification] === \(notification.request.content.userInfo) \n\n");
        completionHandler([.badge,.sound,.alert]);
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        XLOG("\n\n[didReceiveNotificationResponse] === \(response.notification.request.content.userInfo) \n\n");

        // [ GTSdk ]：将收到的APNs信息传给个推统计
        GeTuiSdk.handleRemoteNotification(response.notification.request.content.userInfo);
        completionHandler();
    }
    
    // MARK: - GeTuiSdkDelegate
    /** SDK启动成功返回cid */
    func geTuiSdkDidRegisterClient(_ clientId: String!) {
        // [4-EXT-1]: 个推SDK已注册，返回clientId
        XLOG("\n\n[GeTuiSdk RegisterClient CID] === \(String(describing: clientId)) \n\n");
        UserDefaults.standard.set(clientId, forKey: UserDefaultKeys.AccountInfo.clientId)
    }
    
    /** SDK遇到错误回调 */
    func geTuiSdkDidOccurError(_ error: Error!) {
        // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
        XLOG("\n\n[GeTuiSdk error] === \(error.localizedDescription) \n\n");
    }
    
    /** SDK收到sendMessage消息回调 */
    func geTuiSdkDidSendMessage(_ messageId: String!, result: Int32) {
        // [4-EXT]:发送上行消息结果反馈
        let msg:String = "sendmessage=\(String(describing: messageId)),result=\(result)";
        XLOG("\n\n[GeTuiSdk DidSendMessage] === \(msg) \n\n");
    }
    
    func geTuiSdkDidReceivePayloadData(_ payloadData: Data!, andTaskId taskId: String!, andMsgId msgId: String!, andOffLine offLine: Bool, fromGtAppId appId: String!) {
        
        var payloadMsg = "";
        if((payloadData) != nil) {
            payloadMsg = String.init(data: payloadData, encoding: String.Encoding.utf8)!;
        }
        
        let msg:String = "Receive Payload: \(payloadMsg), taskId:\(String(describing: taskId)), messageId:\(String(describing: msgId))";
        
        XLOG("\n\n[GeTuiSdk DidReceivePayload] === \(msg) \n\n");
    }
    
    
}
