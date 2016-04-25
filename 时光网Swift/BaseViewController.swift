//
//  BaseViewController.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/4/19.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    enum ViewControllerType:Int {
        case Home = 1
        case BookTickets
        case Shopping
        case Discover
        case Users
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.respondsToSelector(Selector("setAutomaticallyAdjustsScrollViewInsets:")) {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "pic_title_bg9"), forBarMetrics: UIBarMetrics.Default)
    }

    func choseTitleView(type:ViewControllerType) {
        switch type {
        case .Home:
            self.navigationController?.navigationBar.hidden = true
            let titleView = UIView(frame: CGRectMake(0,0,100,20))
            let titleImageView = UIImageView(image: UIImage(named: "pic_logo_mtime"))
            titleImageView.frame = CGRectMake(20, 0, 60, 20)
            titleView.addSubview(titleImageView)
            self.navigationItem.titleView = titleView
            break
        case .BookTickets:
            break
        case .Shopping:
            break
        case .Discover:
            break
        case .Users:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
