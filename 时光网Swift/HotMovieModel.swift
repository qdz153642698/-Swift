//
//  HotMovieModel.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/5.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit


/*
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
 */
class HotMovieModel: NSObject {
    var actorName1 : String?
    var actorName2 : String?
    var btnText : String?
    var commonSpecial : String?
    var directorName : String?
    var img : String?
    var is3D : Bool?
    var isDMAX : Bool?
    var isFilter : Bool?
    var isHot : Bool?
    var isIMAX : Bool?
    var isIMAX3D : Bool?
    var isNew : Bool?
    
    var length : Int?
    var movieId : Int?
    
    var nearestShowtime : NSDictionary?
    var isTicket : Bool?
    var nearestCinemaCount : Int?
    var nearestShowDay : Int?
    var nearestShowtimeCount : Int?
    
    var rDay : Int?
    var rMonth : Int?
    var rYear : Int?
    
    var ratingFinal : Float?
    var titleCn : String?
    var titleEn : String?
    var type : String?
    var wantedCount : Int?
    
    var isTodayMovie : Bool?
    var isAdvanceBooking : Bool?
    
    init(dic : NSDictionary) {
        super.init()
        actorName1 = dic["actorName1"] as? String
        actorName2 = dic["actorName2"] as? String
        btnText = dic["btnText"] as? String
        commonSpecial = dic["commonSpecial"] as? String
        
        directorName = dic["directorName"] as? String
        img = dic["img"] as? String
        is3D = dic["is3D"] as? Bool
        isDMAX = dic["isDMAX"] as? Bool
        isFilter = dic["isFilter"] as? Bool
        isHot = dic["isHot"] as? Bool
        isIMAX = dic["isIMAX"] as? Bool
        isIMAX3D = dic["isIMAX3D"] as? Bool
        isNew = dic["isNew"] as? Bool
        
        length = dic["length"] as? Int
        movieId = dic["movieId"] as? Int
        
        nearestShowtime = dic["nearestShowtime"] as? NSDictionary
        isTicket = nearestShowtime?["isTicket"] as? Bool
        nearestCinemaCount = nearestShowtime?["nearestCinemaCount"] as? Int
        nearestShowDay = nearestShowtime?["nearestShowDay"] as? Int
        nearestShowtimeCount = nearestShowtime?["nearestShowtimeCount"] as? Int
        
        rDay = dic["rDay"] as? Int
        rMonth = dic["rMonth"] as? Int
        rYear = dic["rYear"] as? Int
        
        ratingFinal = dic["ratingFinal"] as? Float
        titleCn = dic["titleCn"] as? String
        titleEn = dic["titleEn"] as? String
        type = dic["type"] as? String
        wantedCount = dic["wantedCount"] as? Int
        
        let dateString : [String]? = QDZDateFormatterString().dateFormatterString(string: "yyyy:MM:dd")
        if dateString != nil {
            //isTodatMovie
            if Int(dateString![0]) == rYear && Int(dateString![1]) == rMonth && Int(dateString![2]) == rDay {
                isTodayMovie = true
            }else{
                isTodayMovie = false
            }
            
            if Int(dateString![0])! <= rYear! && Int(dateString![1])! <= rMonth! && Int(dateString![2])! < rDay! {
                isAdvanceBooking = true
            }else{
                isAdvanceBooking = false
            }
            
            
        }
    }
}
