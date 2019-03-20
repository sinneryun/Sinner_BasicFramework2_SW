//
//  Array+Extension.swift
//  smallCrowdStar
//
//  Created by 4wd-ios on 2018/6/29.
//  Copyright © 2018年 ty4wd. All rights reserved.
//

import Foundation
import UIKit

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(_ object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
