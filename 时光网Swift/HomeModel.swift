//
//  HomeModel.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/8.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

/*
 "advList": [
    {
         "gotoPage": {
             "gotoType": "gotomovie",
             "isGoH5": false,
             "parameters": {
                "movieId": 222522
            },
             "parameters1": {
             "movieId": "222522"
             },
             "relatedId": 222522,
             "relatedTypeUrl": "",
             "url": "http://movie.mtime.com/222522/"
         },
         "img": "http://img31.mtime.cn/mg/2016/09/07/084742.28354044.jpg",
         "url": "http://movie.mtime.com/222522/"
     }
 ],
 
 
 */
class HomeModel: NSObject {
    var advLists = [TopPoster]()
//    var mallEntrys = [NSDictionary]()
    init(dic : NSDictionary) {
        super.init()
        let advListArray = dic["advList"] as? [NSDictionary]
        for adv in advListArray! {
            let advElement = TopPoster.init(dic: adv)
            advLists.append(advElement)
        }
        
        
        
    }
    

}
