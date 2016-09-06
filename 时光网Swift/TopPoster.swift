//
//  TopPoster.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/4/19.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

/*
"url": "http://m.mtime.cn/#!/mall/index/",
"keyColor": "#888888",
"img": "http://img31.mtime.cn/mg/2016/04/08/195528.10653431.jpg",
"gotoPage": {
    "gotoType": "gotomallindex",
    "url": "http://m.mtime.cn/#!/mall/index/",
    "parameters": {},
    "parameters1": {},
    "isGoH5": false,
    "relatedTypeUrl": ""
}
*/
class TopPoster: NSObject {
    var url : String?
    var keyColor : String?
    var img : String?
    var gotoPage : GotoPage?
    init(dic:NSDictionary) {
        url = dic["url"] as? String
        keyColor = dic["keyColor"] as? String
        img = dic["img"] as? String
        let gotoPageDic = dic["gotoPage"] as? NSDictionary
        gotoPage = GotoPage.init(dic: gotoPageDic!)
    }

    
}
