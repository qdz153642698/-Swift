//
//  HotMovies.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/5.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit


/*
    "count": 15,
	"movies": [{
         "actorName1": "马特·达蒙",
         "actorName2": "艾丽西亚·维坎德",
         "btnText": "",
         "commonSpecial": "真正的高手是不挑设备的",
         "directorName": "保罗·格林格拉斯",
         "img": "http://img31.mtime.cn/mt/2016/08/16/104651.38128263_1280X720X2.jpg",
         "is3D": true,
         "isDMAX": true,
         "isFilter": false,
         "isHot": true,
         "isIMAX": false,
         "isIMAX3D": true,
         "isNew": false,
         "length": 124,
         "movieId": 223143,
         "nearestShowtime": {
         "isTicket": true,
         "nearestCinemaCount": 148,
         "nearestShowDay": 1472630400,
         "nearestShowtimeCount": 1834
         },
         "rDay": 23,
         "rMonth": 8,
         "rYear": 2016,
         "ratingFinal": 7.6,
         "titleCn": "谍影重重5",
         "titleEn": "Jason Bourne",
         "type": "动作 | 惊悚",
         "wantedCount": 5299
    }]
    "totalCinemaCount": 171,
	"totalComingMovie": 58,
	"totalHotMovie": 52
 */

class HotMovies: NSObject {
    var count : Int = 0
    var movies = [HotMovieModel]()
    var totalCinemaCount : Int = 0
    var totalComingMovie : Int = 0
    var totalHotMovie : Int = 0
    
    init(dic : NSDictionary) {
        super.init()
        count = (dic["count"] as? Int)!
        totalCinemaCount = (dic["totalCinemaCount"] as? Int)!
        totalComingMovie = (dic["totalComingMovie"] as? Int)!
        totalHotMovie = (dic["totalHotMovie"] as? Int)!
        let moviesArray = dic["movies"] as? NSArray
        for i in 0..<(moviesArray?.count)!{
            let movieDic = moviesArray![i] as! NSDictionary
            let movie : HotMovieModel = HotMovieModel.init(dic: movieDic)
            movies.append(movie)
        }
    }
    
    
}
