//
//  PosterDetailViewController.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/4/26.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class PosterDetailViewController: DetailViewController {

    @IBOutlet weak var topLayout: NSLayoutConstraint!
    @IBOutlet weak var webView: UIWebView!
    var _url : String = ""
    var url : String {
        set(str){
            _url = str
        }get{
            return _url
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topLayout.constant = iOS7_Before ? 0.0 : 64.0
        self.choseTitleView(ViewControllerType.BookTickets)
        self.title = "嘿嘿"
        let request = NSURLRequest(URL: NSURL(string: _url)!)
        self.webView.loadRequest(request)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("从试图加载")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}
