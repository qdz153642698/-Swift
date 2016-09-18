//
//  MainTabbarItem.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/4/19.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class MainTabbarButton: UIButton {
    
    func createItem(itemName:String,itemImageNor:String,itemImageSel:String,index:Int,itemWidth:CGFloat) -> UIButton {
        
        let button = UIButton(frame: CGRect.init(x: CGFloat(index)*itemWidth, y: 0, width: itemWidth, height: 49))
        button.setTitle(itemName, for: UIControlState.normal)
        button.setTitleColor(UIColor.blue, for: UIControlState.selected)
        button.setTitleColor(UIColor.gray, for: UIControlState.normal)
        button.setImage(UIImage(named: itemImageNor), for: UIControlState.normal)
        button.setImage(UIImage(named: itemImageSel), for: UIControlState.selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11.0)
        button.titleEdgeInsets = UIEdgeInsetsMake(15, -128, -15, 16)
        button.imageEdgeInsets = UIEdgeInsetsMake(-5, 0, 5, 0)
        button.tag = index
        
        return button
    }

}
