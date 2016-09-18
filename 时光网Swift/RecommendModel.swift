//
//  RecommendModel.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/8.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

/*
 {
     "contentId": 21900667,
     "endTime": 0,
     "goodsId": 0,
     "gotoPage": {
         "gotoType": "gotogoodslist",
         "isGoH5": false,
         "parameters": {
         "keyword": 0
         },
         "parameters1": {
         "keyword": "?salefid=1"
         },
         "relatedId": 0,
         "relatedTypeUrl": "",
         "url": "http://mall.wv.mtime.cn/?salefid=1#!/commerce/list/"
     },
     "image": "http://img5.mtime.cn/mg/2016/09/05/163420.23259554.jpg",
     "position": 1,
     "startTime": 0,
     "title": "闪购专区",
     "titleColor": "#F15353",
     "titleSmall": "精选好货 每日更新",
     "warmup": 0
 }
 */
class RecommendModel: NSObject {
    var contentID : Int = 0
    var endTime : Int = 0
    var goodsId : Int = 0
    var gotoPage : GotoPage?
    var image : String = ""
    var position : Int = 0
    var startTime : Int = 0
    var title : String = ""
    var titleColor : String = ""
    var titleSmall : String = ""
    var warmup : Int = 0
    var color : UIColor? = UIColor.black
    init(dic : NSDictionary) {
        contentID = (dic["contentId"] as? Int)!
        endTime = (dic["endTime"] as? Int)!
        goodsId = (dic["goodsId"] as? Int)!
        let gotoPageDic = dic["gotoPage"] as? NSDictionary
        gotoPage = GotoPage.init(dic: gotoPageDic!)
        image = (dic["image"] as? String)!
        position = (dic["position"] as? Int)!
        startTime = (dic["startTime"] as? Int)!
        title = (dic["title"] as? String)!
        titleColor = (dic["titleColor"] as? String)!
        titleSmall = (dic["titleSmall"] as? String)!
        warmup = (dic["warmup"] as? Int)!
        if title != "" {
            color = UIColor.QDZ_Color_Conversion(Color_Value: titleColor as NSString)
        }
    }
}
