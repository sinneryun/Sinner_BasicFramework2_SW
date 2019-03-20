//
//  ViewController.swift
//  xiaohailang
//
//  Created by 刘达浮云 on 2019/2/14.
//  Copyright © 2019 刘达浮云. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


fileprivate var httpHeaders = ["Content-Type" : "application/json"]

//创建单例对象
class NetworkTools: NSObject {
    static let shareInstance: NetworkTools = {
        let tools = NetworkTools()
        return tools
    }()
}

extension NetworkTools {
    //获取Token
    func getToken() {
        let userDefault = UserDefaults.standard
        if userDefault.object(forKey: UserDefaultKeys.LoginInfo.token) != nil {
            let userToken: String = userDefault.string(forKey: UserDefaultKeys.LoginInfo.token)!
            let AuthorToken = "Bearer \(userToken)"
            httpHeaders["Authorization"] =  AuthorToken
        }
    }
    
    // 拼接参数
    func jointParams(urlString: String, params : [String : Any]) -> String {
        var jointUrl = urlString + "?"
        
        for (key, value) in params {
            jointUrl += "\(key)=\(value)&"
        }
        jointUrl.removeLast()
        
        return jointUrl
    }
    
    //MARK: - GET 请求
    func getRequest(urlString: String, params : [String : Any]?, success : @escaping (_ response : JSON)->(), failture : @escaping (_ error : Error)->()) {
        //使用Alamofire进行网络请求时，调用该方法的参数都是通过getRequest(urlString， params, success :, failture :）传入的，而success传入的其实是一个接受[String : AnyObject]类型 返回void类型的函数
        
        self.getToken()//获取token
        
        // 拼接参数
        
        var jointUrl = urlString
        if params != nil {
            jointUrl = self.jointParams(urlString: urlString, params: params!)
        }
        
        Alamofire.request(HOST_URL + jointUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: httpHeaders).responseJSON { (response) in/*这里使用了闭包*/
            //使用switch判断请求是否成功，也就是response的result
            switch response.result {
            case .success:
                //当响应成功后，判断服务器返回的信息是否为[String: AnyObject]类型，如果是转换成JSON传给success
                if let value = response.result.value as? [String: AnyObject] {
                    
                    XLOG("\n=================MSG====================\n \(value["msg"]!)\n=================MSG====================")
                    
                    var code: Int = 0
                    if let tempCode = value["code"] {
                        code = tempCode is String ? Int(tempCode as! String)! : tempCode as! Int
                    }
                    
                    if code == 200 {
                        success(JSON(value))
                    }else if code == 402{
                        let nowViewController = UIViewController.currentViewController()
//                        let loginVC = WDLLoginVC()
//                        let loginNav = UINavigationController(rootViewController: loginVC)
//                        nowViewController?.present(loginNav, animated: true, completion: nil)
                       
                    }else{
                         HUDTools.showMoment(value["msg"] as? String)
                    }
                }
                
            case .failure(let error):
                failture(error)
                XLOG("error:\(error)")
            }
        }
        
    }
    //MARK: - POST 请求
    func postRequest(urlString : String, params : [String : Any]?, success : @escaping (_ response : JSON)->(), failture : @escaping (_ error : Error)->()) {
        
        self.getToken()//获取token
        
        Alamofire.request(HOST_URL + urlString, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: httpHeaders).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value as? [String: AnyObject] {
                    XLOG("\n=================MSG====================\n \(value["msg"]!)\n=================MSG====================")
                    
                    var code: Int = 0
                    if let tempCode = value["code"] {
                        code = tempCode is String ? Int(tempCode as! String)! : tempCode as! Int
                    }
                    
                    // 301为微信登录绑定手机号
                    if code == 200 || code == 301{
                        success(JSON(value))
                    }else{
                        HUDTools.showMoment(value["msg"] as? String)
                    }
                    
                    
                }
                
            case .failure(let error):
                failture(error)
                XLOG("error:\(error)")
            }
            
        }
    }
    
    //MARK: - 照片上传
    
    // - Parameters:
    //   - urlString: 服务器地址
    //   - params: ["flag":"","userId":""] - flag,userId 为必传参数
    //   flag - 666 信息上传多张  －999 服务单上传  －000 头像上传
    //   - data: image转换成Data
    //   - name: fileName
    //   - success:
    //   - failture:
    func upLoadImageRequest(urlString : String, params:[String:String], data: [Data], name: [String],success : @escaping (_ response : JSON)->(), failture : @escaping (_ error : Error)->()){
        
        let uploadHeaders = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //666多张图片上传
                let flag = params["flag"]
                let userId = params["userId"]
                
                multipartFormData.append((flag?.data(using: String.Encoding.utf8)!)!, withName: "flag")
                multipartFormData.append( (userId?.data(using: String.Encoding.utf8)!)!, withName: "userId")
                
                for i in 0..<data.count {
                    multipartFormData.append(data[i], withName: "appPhoto", fileName: name[i], mimeType: "image/png")
                }
        },
            to: HOST_URL + urlString,
            headers: uploadHeaders,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject] {
                            success(JSON(value))
                        }
                    }
                case .failure(let encodingError):
                    failture(encodingError)
                    XLOG(encodingError)
                }
        }
        )
    }
    
}


extension UIViewController {
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
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
}





