//
//  MainTabBarViewController.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/4/19.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    let KScreenWidth = UIScreen.mainScreen().bounds.width
    let KScreenHeight = UIScreen.mainScreen().bounds.height
    var selectedButton : UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()

        createSubViewControllers()
        
        //创建TabbarItem
        createTabbarItem()
        
    }
    
    func createTabbarItem() {
        for subView in tabBar.subviews {
            let classStr = NSClassFromString("UITabBarButton")
            if subView.isKindOfClass(classStr!) {
                subView.removeFromSuperview()
            }
        }
        
        let itemNames = ["首页","购票","商城","发现","我的"]
        let itemImagesNor = ["tab_home01","tab_payticket01","tab_shop01","tab_discover01","user01"]
        let itemImagesSel = ["tab_home02","tab_payticket02","tab_shop02","tab_discover02","user02"]
        let itemWidth = KScreenWidth / CGFloat(itemNames.count)
        let mainTabbarButton = MainTabbarButton()
        let tabbarView = UIView(frame: CGRectMake(0,0,KScreenWidth,49))
        tabbarView.backgroundColor = UIColor.whiteColor()
        self.tabBar.addSubview(tabbarView)
        for i in 0...4 {
            let itemName = itemNames[i]
            let itemImageNor = itemImagesNor[i]
            let itemImageSel = itemImagesSel[i]
            
            let button = mainTabbarButton.createItem(itemName, itemImageNor: itemImageNor, itemImageSel: itemImageSel,index: i,itemWidth:itemWidth)
            tabbarView.addSubview(button)
            if i == 0 {
                button.selected = true
                selectedButton = button
            }
            button.addTarget(self, action: #selector(MainTabBarViewController.itemClickAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
    }
    
    func itemClickAction(button:UIButton) {
        if selectedButton != button {
            selectedButton?.selected = false
            button.selected = true
            selectedButton = button
            self.selectedIndex = button.tag
        }
    }
    
    func createSubViewControllers() {
        let home = HomeViewController()
        let bookTickets = BookTicketsViewController()
        let shopping = ShoppingViewController()
        let discover = DiscoverViewController()
        let users = UsersViewController()
        let ctArray = [home,bookTickets,shopping,discover,users]
        
        for ct in ctArray {
            let navigation = MainNavigationViewController(rootViewController: ct)
            self.addChildViewController(navigation)
        }
        
        self.selectedIndex = 0
        
        
    }
}
