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
        
        let button = UIButton(frame: CGRectMake(CGFloat(index)*itemWidth,0,itemWidth,49))
        button.setTitle(itemName, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Selected)
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        button.setImage(UIImage(named: itemImageNor), forState: UIControlState.Normal)
        button.setImage(UIImage(named: itemImageSel), forState: UIControlState.Selected)
        button.titleLabel?.font = UIFont.systemFontOfSize(11.0)
        button.titleEdgeInsets = UIEdgeInsetsMake(15, -128, -15, 16)
        button.imageEdgeInsets = UIEdgeInsetsMake(-5, 0, 5, 0)
        button.tag = index
        
        return button
    }

}
