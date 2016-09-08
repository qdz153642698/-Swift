//
//  HomeViewController.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/4/19.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController ,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TimerScrollViewDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topLayout: NSLayoutConstraint!
    var topPosterArray = [TopPoster]()
    let TimeFeaturedCollectionCell = "TimeFeaturedCollectionCell"
    let TopPostersCollectionElementCell = "TopPostersCollectionElementCell"
    let SalingTicketsCollectionCell = "SalingTicketsCollectionCell"
    let HotPlayersCollectionCell = "HotPlayersCollectionCell"
    let HotPlayersSecondCollectionCell = "HotPlayersSecondCollectionCell"
    var timerScrollView : TimerScrollView?
    var pageIndex : Int = 0
    var hotMovies : HotMovies?
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //导航栏随视图拖动改变北京颜色
        self.scrollViewDidScroll(self.collectionView)
        self.navigationController?.navigationBar.shadowImage = UIImage.init()
        
        self.topLayout.constant = iOS7_Before ? 0.0 : 0.0
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49.0, 0)
        self.choseTitleView(ViewControllerType.Home)

        let topPosterNib : UINib = UINib.init(nibName: "TopPostersCollectionReusableView", bundle: nil)
        self.collectionView.registerNib(topPosterNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: TopPostersCollectionElementCell)
        
        let salingTicketsNib : UINib = UINib.init(nibName: "SalingTicketsCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(salingTicketsNib, forCellWithReuseIdentifier: SalingTicketsCollectionCell)
        
        let hotPlayersNib : UINib = UINib.init(nibName: "HotPlayersCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(hotPlayersNib, forCellWithReuseIdentifier: HotPlayersCollectionCell)
        
        let hotPlayersSecondNib : UINib = UINib.init(nibName: "HotPlayersSecondCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(hotPlayersSecondNib, forCellWithReuseIdentifier: HotPlayersSecondCollectionCell)
        
        let timeFeaturedNib : UINib = UINib.init(nibName: "TimeFeaturedCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(timeFeaturedNib, forCellWithReuseIdentifier: TimeFeaturedCollectionCell)
        
        //从本地加载数据（有空再换成网络请求）
//        loadDataHotPlayersFromLocaJson()   
        
        //(topPoster)
        loadDataFromNetwork()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.scrollViewDidScroll(self.collectionView)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.reset()
    }
    
    func loadDataTopPostersFromLocaJson() {
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
        
        self.collectionView.reloadData()
    }
    
    func loadDataHotPlayersFromLocaJson(){
        let path : String = NSBundle.mainBundle().pathForResource("HotPlayers", ofType: "json")!
        let data = NSData(contentsOfFile: path)
        if data != nil {
            let dictionary : NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
            self.hotMovies = HotMovies.init(dic: dictionary)
        }
        self.collectionView.reloadData()
    }
    
    func loadDataHotPlayersFromNetwork(){
        let dic = [String:String]()
        let manager = SGNetWorkManager.shareInstance
        manager.getDataTaskWithURL_params_completion("\(SGBaseURL)//PageSubArea/HotPlayMovies.api?locationId=290", params: dic, successCompletion: { (json) -> Void in
            print("JSON : \(json)")
            self.hotMovies = HotMovies.init(dic: json)
            self.collectionView.reloadData()
        }) { (error) -> Void in
            print("居然发生了错误")
        }
        
    }
    
    //网络请求
    func loadDataFromNetwork() {
        let dic = [String:String]()
        let manager = SGNetWorkManager.shareInstance
        manager.getDataTaskWithURL_params_completion("\(SGCommURL)/home/index.api?subSecondParam=3%7C20245003%2324%230,1%7C21900667%2324%231,6%7C20245005%2324%230,2%7C20245002%2324%230,7%7C20245006%2324%230,5%7C20245004%2324%230", params: dic, successCompletion: { (json) -> Void in
                print("JSON : \(json)")
            let code : Int = Int(json["code"] as! String)!
            if Code(code) == true{
                let data = json["data"] as! NSDictionary
                let array = data["topPosters"] as! NSArray
                for dic in array{
                    let topPosterModel = TopPoster.init(dic: (dic as! NSDictionary))
                    print(topPosterModel.url)
                    self.topPosterArray.append(topPosterModel)
                }
                //HotPlayers
                self.loadDataHotPlayersFromNetwork()
            }
            }) { (error) -> Void in
                print("居然发生了错误")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        return topPosterArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if indexPath.item == 0 {
                let cell : SalingTicketsCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(SalingTicketsCollectionCell, forIndexPath: indexPath) as! SalingTicketsCollectionViewCell
                cell.cityName = "北京"
                cell.movies = self.hotMovies?.totalHotMovie
                return cell
            }else if indexPath.item == 1{
                let cell : HotPlayersCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(HotPlayersCollectionCell, forIndexPath: indexPath) as! HotPlayersCollectionViewCell
                cell.hotMovies = self.hotMovies?.movies
                return cell
            }else{
                let cell : HotPlayersSecondCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(HotPlayersSecondCollectionCell, forIndexPath: indexPath) as! HotPlayersSecondCollectionViewCell
                if self.hotMovies != nil{
                    cell.comingMovieValue = self.hotMovies?.totalComingMovie
                    cell.cinemas = self.hotMovies?.totalCinemaCount
                }
                return cell;
            }
        }
        let cell : TimeFeaturedCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(TimeFeaturedCollectionCell, forIndexPath: indexPath) as! TimeFeaturedCollectionViewCell
        cell.setPoster(self.topPosterArray[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        weak var weakSelf = self
        let cell : TopPostersCollectionReusableView =  collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: TopPostersCollectionElementCell, forIndexPath: indexPath) as! TopPostersCollectionReusableView
        cell.posters = self.topPosterArray
        cell.pageIndex = pageIndex
        cell.timerScrollView.timerDelegate = self
        cell.searchButton.handleWithBlock {
            weakSelf?.searchButtonAction()
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 0 {
            if indexPath.item == 0 || indexPath.item == 2{
                return CGSizeMake(KScreenWidth, 45.0)
            }else{
                return CGSizeMake(KScreenWidth, 225)
            }
        }
        
        return CGSizeMake(KScreenWidth, 200)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeMake(KScreenWidth, 168.0)
        }else{
            return CGSizeMake(KScreenWidth, 0.1)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeMake(KScreenWidth, 0.1)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func searchButtonAction(){
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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        print("正在滑动，偏移量：\(scrollView.contentOffset.y)")
        let alpha = scrollView.contentOffset.y / 64.0;
        let color = UIColor(colorLiteralRed: 32.0/255.0, green: 131.0/255.0, blue: 198.0/255.0, alpha: Float(alpha))
        self.navigationController?.navigationBar.qdz_setBackgroundColor(color)
        self.navigationController?.navigationBar.qdz_setElementsAlpha(alpha)
    }
    
    
}
