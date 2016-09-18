//
//  QDZDateFormatterString.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/6.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class QDZDateFormatterString: NSObject {
    
    func dateFormatterString(string : String) -> [String]?{
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = string
        let dateString = dateFormat.string(from: NSDate.init() as Date)
        if string.contains(":") == true {
            return dateString.components(separatedBy: ":")
        }else if string.contains("-") == true {
            return dateString.components(separatedBy: "-")
        }
        return nil

        
        
    }
    
}
