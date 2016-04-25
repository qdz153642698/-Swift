//
//  GotoPage.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/4/19.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

/*
"gotoType": "gotomallindex",
"url": "http://m.mtime.cn/#!/mall/index/",
"parameters": {},
"parameters1": {},
"isGoH5": false,
"relatedTypeUrl": ""
*/
class GotoPage: NSObject {
    
    var gotoType : String?
    var url : String?
    var parameters : [String:Int]?
    var parameters1 : [String:String]?
    var isGoH5 : Bool?
    var relatedTypeUrl : String?
    
    init(dic:NSDictionary) {
        gotoType = dic["gotoType"] as? String
        url = dic["url"] as? String
        parameters = dic["parameters"] as? [String : Int]
        parameters1 = dic["parameters1"] as? [String : String]
        isGoH5 = dic["isGoH5"] as? Bool
        relatedTypeUrl = dic["relatedTypeUrl"] as? String
    }
        
        
    
}
