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
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout=UIRectEdge.None
        self.extendedLayoutIncludesOpaqueBars = true
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 32.0/255.0, green: 131.0/255.0, blue: 198.0/255.0, alpha: 1)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.hidden = true
        self.navigationController?.navigationBar.alpha = 0
    }

    func choseTitleView(type:ViewControllerType) {
        switch type {
        case .Home:
            let titleView = UIView(frame: CGRectMake(0,0,100,20))
            let titleImageView = UIImageView(image: UIImage(named: "pic_logo_mtime"))
            titleImageView.frame = CGRectMake(20, 0, 60, 20)
            titleView.addSubview(titleImageView)
            self.navigationItem.titleView = titleView
            break
        case .BookTickets:
            let titleView = UIView(frame: CGRectMake(0,0,100,20))
            let titleImageView = UIImageView(image: UIImage(named: "pic_logo_mtime"))
            titleImageView.frame = CGRectMake(20, 0, 60, 20)
            titleView.addSubview(titleImageView)
            self.navigationItem.titleView = titleView

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
