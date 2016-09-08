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
        let dateFormat = NSDateFormatter.init()
        dateFormat.dateFormat = string
        let dateString = dateFormat.stringFromDate(NSDate.init())
        if string.containsString(":") == true {
            return dateString.componentsSeparatedByString(":")
        }else if string.containsString("-") == true{
            return dateString.componentsSeparatedByString("-")
        }
        
        return nil
    }
    
}
