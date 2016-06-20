//
//  HomeViewController.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/4/19.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController ,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,TimerScrollViewDelegate{

    
    @IBOutlet weak var tableView: UITableView!
    var topPosterArray = [TopPoster]()
    var cellID = "cell"
    var timerScrollView : TimerScrollView?
    var pageIndex : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad() 
        self.choseTitleView(ViewControllerType.Home)
        let nib : UINib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: cellID)
        
//        loadDataFromLocaJson()    //加载本地json文件
        
        loadDataFromNetwork() //网络请求
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func loadDataFromLocaJson() {
        let path = NSBundle.mainBundle().pathForResource("test", ofType: "json")
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dictionary : NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            let array = dictionary["topPosters"] as! NSArray
            for dic in array{
                let topPosterModel = TopPoster.init(dic: (dic as! NSDictionary))
                print(topPosterModel.url)
                topPosterArray.append(topPosterModel)
            }
        }
        
        self.tableView.reloadData()
     
    }
    
    //网络请求
    func loadDataFromNetwork() {
        let dic = [String:String]()
        let manager = SGNetWorkManager.shareInstance
        manager.getDataTaskWithURL_params_completion("\(SGBaseURL)/PageSubArea/GetFirstPageAdvAndNews.api?subFifthParam=20245004%2315%230&subFistParam=20245001%2315%230&subSecondParam=20245002%2315%230&subSevenParam=20245006%2315%230&subSixParam=20245005%2315%230&subThirdParam=20245003%2315%230", params: dic, successCompletion: { (json) -> Void in
                print("JSON : \(json)")
                let array = json["topPosters"] as! NSArray
                for dic in array{
                    let topPosterModel = TopPoster.init(dic: (dic as! NSDictionary))
                    print(topPosterModel.url)
                    self.topPosterArray.append(topPosterModel)
                }
                self.tableView.performSelectorOnMainThread(Selector("reloadData"), withObject: nil, waitUntilDone: false)
            }) { (error) -> Void in
                print("居然发生了错误")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return topPosterArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DemoTableViewCell
        cell.setPoster(topPosterArray[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("正在滑动，偏移量：\(scrollView.contentOffset.y)")
        
        let bili = CGFloat(1) / 64.0
        if scrollView.contentOffset.y > 0 {
            self.navigationController?.navigationBar.hidden = false
            let alpha = scrollView.contentOffset.y * bili
            self.navigationController?.navigationBar.alpha = alpha
        }else{
            self.navigationController?.navigationBar.hidden = true
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 150.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            
            if timerScrollView != nil {
                timerScrollView?.timerSuspend()
                timerScrollView?.removeFromSuperview()
            }
            
            
            timerScrollView = TimerScrollView()
            timerScrollView!.frame = CGRectMake(0, 0, KScreenWidth, 150.0)
            timerScrollView!.timerDelegate = self
            var imgUrlArray = [String]()
            for poster in topPosterArray {
                imgUrlArray.append(poster.img!)
            }
            
            if imgUrlArray.count >= 1 {
                timerScrollView!.configScrollView(imgUrlArray,contentOffsetIndex: pageIndex)
            }
            
            let searchButton = UIButton(frame: CGRectMake(0,150.0-18.0,KScreenWidth,36))
            searchButton.setBackgroundImage(UIImage(named: "home_search_background"), forState: UIControlState.Normal)
            searchButton.addTarget(self, action: Selector("searchButtonAction:"), forControlEvents: UIControlEvents.TouchUpInside)
            timerScrollView?.addSubview(searchButton)
            
            return timerScrollView
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 150.0
        }
        return 0.0
    }
    
    
    func searchButtonAction(button:UIButton){
        print("搜索")
    }
    
    func scrollToIndexOfPage(index: Int) {
        pageIndex = index
    }
    
    func tapActionIndexOfPage(index: Int) {
        print("点击区域：\(index)")
        let topPster = topPosterArray[index]
        print("\(topPster.gotoPage?.url)")
        let posterVC = PosterDetailViewController(nibName: "PosterDetailViewController", bundle: nil)
        posterVC.url = (topPster.gotoPage?.url)!
        self.navigationController?.pushViewController(posterVC, animated: true)
    }
    
    
    
    
}
