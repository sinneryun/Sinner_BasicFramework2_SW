//
//  ViewController.swift
//  xiaohailang
//
//  Created by 刘达浮云 on 2019/2/14.
//  Copyright © 2019 刘达浮云. All rights reserved.
//

import UIKit
//import SecViewController

class ViewController: BaseViewController {
    
    
    private var secLab: UILabel!
    private var textF: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "第一页"
        
        
    }
    
    
    
    override func createUI() {
        
        let oneBtn = UIButton(frame: CGRect(x: 30, y: 100, width: 50, height: 50))
        oneBtn.backgroundColor = UIColor.blue
        self.view.addSubview(oneBtn)
        oneBtn.addTarget(self, action: #selector(shareClick), for: UIControl.Event.touchUpInside)
        
        
        let secLab = UILabel(frame: CGRect(x: 50, y: 150, width: 200, height: 30))
        self.secLab = secLab
        secLab.font = UIFont.systemFont(ofSize: 20)
        secLab.text = "what are you bibi"
        self.view.addSubview(secLab)
        
        textF = UITextField(frame:CGRect(x: 50, y: 200, width: HL_APP_WIDTH - 100, height: 30))
        textF.backgroundColor = UIColor.white
        self.view.addSubview(textF)
        
    }
    
    @objc func shareClick() {
        
        XLOG("test share")
        
        let img = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551679983363&di=5965720c4228aa574f445c7fcf75d06e&imgtype=0&src=http%3A%2F%2Fqimg.hxnews.com%2F2019%2F0130%2F1548847547452.jpg"
        let url = "http://www.baidu.com"
        
        ShareTools.share(shareTitle: "测试一哈哈", shareText: "no textno textno textno text", shareImg: img, shareUrlStr: url, shareType: .auto)
        
        
        
        
        
        
        
        
        
        
    }
    
    
}


