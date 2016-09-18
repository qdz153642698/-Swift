//
//  HomeModel.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/8.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class HomeModel: NSObject {
    var advLists = [TopPoster]()
    var mallEntrys = [MallEntrysModel]()
    lazy var mallEntrysDef : [NSDictionary] = {
        var entrys = [NSDictionary]()
        let entryOne = ["image" : "home_entry0","title" : "时光热榜"]
        let entryTwo = ["image" : "home_entry1","title" : "全球票房榜"]
        let entryThree = ["image" : "home_entry2","title" : "新片预告"]
        let entryFour = ["image" : "home_entry3","title" : "猜电影"]
        entrys.append(entryOne as NSDictionary)
        entrys.append(entryTwo as NSDictionary)
        entrys.append(entryThree as NSDictionary)
        entrys.append(entryFour as NSDictionary)
        return entrys
    }()
    var mallRecommends = [RecommendModel]()
    var searchBarDescribe : String = ""
//    var specialTopicList = [NSDictionary]()
    var topPosters = [TopPoster]()
    var msg : String = ""
    var showMsg : String = ""
    init(dic : NSDictionary) {
        super.init()
        let advListArray = dic["advList"] as? [NSDictionary]
        if advListArray != nil {
            for adv in advListArray! {
                let advElement = TopPoster.init(dic: adv)
                advLists.append(advElement)
            }
        }
        
        let recommendArray = dic["mallRecommends"] as? [NSDictionary]
        if recommendArray != nil {
            for recommend in recommendArray! {
                let recommendElement = RecommendModel.init(dic: recommend)
                mallRecommends.append(recommendElement)
            }
        }
        
        searchBarDescribe = (dic["searchBarDescribe"] as? String)!
        
        let topPosterArray = dic["topPosters"] as? [NSDictionary]
        if topPosterArray != nil {
            for topPoster in topPosterArray! {
                let topPosterElement = TopPoster.init(dic: topPoster)
                topPosters.append(topPosterElement)
            }
        }
        
        let mallEntryArray = dic["mallEntrys"] as? [NSDictionary]
        if mallEntryArray != nil {
            
        }
    }
    

}
