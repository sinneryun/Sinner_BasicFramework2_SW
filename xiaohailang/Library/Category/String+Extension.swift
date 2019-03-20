//
//  String+Extension.swift
//  smallCrowdStar
//
//  Created by 4wd-ios on 2018/6/22.
//  Copyright © 2018年 ty4wd. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func wd_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    func wd_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func wd_YYLabelHeight(fontSize: CGFloat, lineSpacing: CGFloat, width: CGFloat) -> CGFloat {
        let text = NSMutableAttributedString(string: self)
        text.yy_font = UIFont.systemFont(ofSize: fontSize)
        text.yy_lineSpacing = lineSpacing
        
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let layout = YYTextLayout(containerSize: size, text: text)
        let textHeight = layout?.textBoundingSize.height
        return textHeight!
    }
    
    
}


