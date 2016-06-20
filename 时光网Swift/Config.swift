//
//  Config.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/4/20.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import Foundation

let KScreenWidth = UIScreen.mainScreen().bounds.width
let KScreenHeight = UIScreen.mainScreen().bounds.height

var systemVersion = Float(UIDevice.currentDevice().systemVersion)

var iOS7_Before = systemVersion < 7.0 ? true : false
var iOS7_Later = systemVersion >= 7.0 ? true : false
var iOS8_Later = systemVersion >= 8.0 ? true : false
var iOS9_Later = systemVersion >= 9.0 ? true : false
