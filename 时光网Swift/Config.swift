//
//  Config.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/4/20.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import Foundation

let KScreenWidth = UIScreen.main.bounds.width
let KScreenHeight = UIScreen.main.bounds.height

var systemVersion : Double! = Double(UIDevice.current.systemVersion)

var iOS7_Before = systemVersion < 7.0 ? true : false
var iOS7_Later = systemVersion >= 7.0 ? true : false
var iOS8_Later = systemVersion >= 8.0 ? true : false
var iOS9_Later = systemVersion >= 9.0 ? true : false

func ColorWithRGB(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat) -> UIColor{
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
}

func Code(code:Int) -> Bool{
    if code == 0 || code == 1 {
        return true
    }else{
        return false
    }
}

func ColorFromRGB16Hex(value : UInt32) -> UIColor {
    let red = ((value & 0xFF0000) >> 16) / 0xff
    let green = ((value & 0x00FF00) >> 8) / 0xff
    let blue = (value & 0x0000FF) / 0xff
    let color = ColorWithRGB(r: CGFloat(red), g: CGFloat(green), b: CGFloat(blue), alpha: 1)
    return color
}
