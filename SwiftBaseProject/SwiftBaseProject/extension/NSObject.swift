//
//  NSObject.swift
//  SwiftBaseProject
//
//  Created by 許　駿 on 2019/05/25.
//  Copyright © 2019年 kyo_s. All rights reserved.
//

import Foundation

// classNameの取得
extension NSObject {

    class var className: String{
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }

}
