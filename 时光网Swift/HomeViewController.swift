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
    var homeModel : HomeModel?
    let TimeFeaturedCollectionCell = "TimeFeaturedCollectionCell"
    let TopPostersCollectionElementCell = "TopPostersCollectionElementCell"
    let SalingTicketsCollectionCell = "SalingTicketsCollectionCell"
    let HotPlayersCollectionCell = "HotPlayersCollectionCell"
    let HotPlayersSecondCollectionCell = "HotPlayersSecondCollectionCell"
    let CollectionElementKindHeaderClass = "CollectionElementKindHeaderClass"
    let CollectionElementKindFooterClass = "CollectionElementKindFooterClass"
    let MoviesMallCollectionCell = "MoviesMallCollectionCell"
    let MoviesMallItemCollectionCell = "MoviesMallItemCollectionCell"
    let AdvListCollectionCell = "AdvListCollectionCell"
    let AdvListTimerForScrollCollectionCell = "AdvListTimerForScrollCollectionCell"
    var pageIndex : Int = 0
    var advListPageIndex : Int = 0
    var hotMovies : HotMovies?
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //导航栏随视图拖动改变北京颜色
        self.collectionView.backgroundColor = ColorWithRGB(r: 243, g: 243, b: 243, alpha: 1)
        self.scrollViewDidScroll(self.collectionView)
        self.navigationController?.navigationBar.shadowImage = UIImage.init()
        
        self.topLayout.constant = iOS7_Before ? 0.0 : 0.0
        self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49.0, 0)
        self.choseTitleView(type: ViewControllerType.Home)

        let topPosterNib : UINib = UINib.init(nibName: "TopPostersCollectionReusableView", bundle: nil)
        self.collectionView.register(topPosterNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: TopPostersCollectionElementCell)
        let salingTicketsNib : UINib = UINib.init(nibName: "SalingTicketsCollectionViewCell", bundle: nil)
        self.collectionView.register(salingTicketsNib, forCellWithReuseIdentifier: SalingTicketsCollectionCell)
        let hotPlayersNib : UINib = UINib.init(nibName: "HotPlayersCollectionViewCell", bundle: nil)
        self.collectionView.register(hotPlayersNib, forCellWithReuseIdentifier: HotPlayersCollectionCell)
        let hotPlayersSecondNib : UINib = UINib.init(nibName: "HotPlayersSecondCollectionViewCell", bundle: nil)
        self.collectionView.register(hotPlayersSecondNib, forCellWithReuseIdentifier: HotPlayersSecondCollectionCell)
        let timeFeaturedNib : UINib = UINib.init(nibName: "TimeFeaturedCollectionViewCell", bundle: nil)
        self.collectionView.register(timeFeaturedNib, forCellWithReuseIdentifier: TimeFeaturedCollectionCell)
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CollectionElementKindHeaderClass)
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: CollectionElementKindFooterClass)
        let moviesMallNib : UINib = UINib.init(nibName: "MoviesMallCollectionViewCell", bundle: nil)
        self.collectionView.register(moviesMallNib, forCellWithReuseIdentifier: MoviesMallCollectionCell)
        let moviesMallItemNib : UINib = UINib.init(nibName: "MoviesMallItemCollectionViewCell", bundle: nil)
        self.collectionView.register(moviesMallItemNib, forCellWithReuseIdentifier: MoviesMallItemCollectionCell)
        let advListNib : UINib = UINib.init(nibName: "AdvListCollectionViewCell", bundle: nil)
        self.collectionView.register(advListNib, forCellWithReuseIdentifier: AdvListCollectionCell)
        let advListTimerNib : UINib = UINib.init(nibName: "AdvListTimerForScrollCollectionViewCell", bundle: nil)
        self.collectionView.register(advListTimerNib, forCellWithReuseIdentifier: AdvListTimerForScrollCollectionCell)
        
        //(topPoster)
        loadDataFromNetwork()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.scrollViewDidScroll(self.collectionView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.reset()
    }
    
    //加载本地数据（防止时光网更改协议出现问题，暂不删除）
    func loadDataHotPlayersFromLocaJson(){
        let path : String = Bundle.main.path(forResource: "HotPlayers", ofType: "json")!
        let data = NSData(contentsOfFile: path)
        if data != nil {
            let dictionary : NSDictionary = (try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            self.hotMovies = HotMovies.init(dic: dictionary)
        }
        self.collectionView.reloadData()
    }
    
    //网络请求
    func loadDataFromNetwork() {
        let dic = [String:String]()
        let manager = SGNetWorkManager.shareInstance
        manager.getDataTaskWithURL_params_completion(url: "\(SGCommURL)/home/index.api?subSecondParam=3%7C20245003%2324%230,1%7C21900667%2324%231,6%7C20245005%2324%230,2%7C20245002%2324%230,7%7C20245006%2324%230,5%7C20245004%2324%230", params: dic as NSDictionary, successCompletion: { (json) -> Void in
                print("JSON : \(json)")
            let code : Int = Int(json["code"] as! String)!
            if Code(code: code) == true{
                let data = json["data"] as? NSDictionary
                if data != nil {
                    self.homeModel = HomeModel.init(dic: data!)
                    self.loadDataHotPlayersFromNetwork()
                }
            }
            }) { (error) -> Void in
                print("居然发生了错误")
        }
        
    }
    
    //加载热映数据
    func loadDataHotPlayersFromNetwork(){
        let dic = [String:String]()
        let manager = SGNetWorkManager.shareInstance
        manager.getDataTaskWithURL_params_completion(url: "\(SGBaseURL)//PageSubArea/HotPlayMovies.api?locationId=290", params: dic as NSDictionary, successCompletion: { (json) -> Void in
            print("JSON : \(json)")
            self.hotMovies = HotMovies.init(dic: json)
            self.collectionView.reloadData()
        }) { (error) -> Void in
            print("居然发生了错误")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else if section == 1 {
            return 2
        }else if section == 2 {
            if self.homeModel != nil {
                return (self.homeModel?.mallEntrys.count)! > 0 ? (self.homeModel?.mallEntrys.count)! : 4
            }else{
                return 0
            }
        }else if section == 3 {
            return self.homeModel != nil ? 1 : 0
        }
        return self.homeModel != nil ? (self.homeModel?.topPosters.count)! : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if indexPath.item == 0 {
                let cell : SalingTicketsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: SalingTicketsCollectionCell, for: indexPath as IndexPath) as! SalingTicketsCollectionViewCell
                cell.cityName = "北京"
                cell.movies = self.hotMovies?.totalHotMovie
                return cell
            }else if indexPath.item == 1{
                let cell : HotPlayersCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HotPlayersCollectionCell, for: indexPath as IndexPath) as! HotPlayersCollectionViewCell
                cell.hotMovies = self.hotMovies?.movies
                return cell
            }else{
                let cell : HotPlayersSecondCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HotPlayersSecondCollectionCell, for: indexPath as IndexPath) as! HotPlayersSecondCollectionViewCell
                if self.hotMovies != nil{
                    cell.comingMovieValue = self.hotMovies?.totalComingMovie
                    cell.cinemas = self.hotMovies?.totalCinemaCount
                }
                return cell;
            }
        }else if indexPath.section == 1 {
            if indexPath.item == 0 {
                let cell : MoviesMallCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesMallCollectionCell, for: indexPath as IndexPath) as! MoviesMallCollectionViewCell
                return cell
            }else{
                let cell : MoviesMallItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesMallItemCollectionCell, for: indexPath as IndexPath) as! MoviesMallItemCollectionViewCell
                cell.mallArray = self.homeModel?.mallRecommends
                return cell
            }
        }else if indexPath.section == 2 {  //小圆点
            let cell : AdvListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvListCollectionCell, for: indexPath as IndexPath) as! AdvListCollectionViewCell
            if (self.homeModel?.mallEntrys.count)! > 0 {
                cell.entrys = self.homeModel?.mallEntrys[indexPath.item]
            }else{
                cell.entrysDic = self.homeModel?.mallEntrysDef[indexPath.item]
            }
            return cell;
        }else if indexPath.section == 3 {
            let cell : AdvListTimerForScrollCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvListTimerForScrollCollectionCell, for: indexPath as IndexPath) as! AdvListTimerForScrollCollectionViewCell
            cell.posters = self.homeModel?.advLists
            cell.pageIndex = advListPageIndex
            cell.advScrollView.timerDelegate = self
            return cell
        }
        let cell : TimeFeaturedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeFeaturedCollectionCell, for: indexPath as IndexPath) as! TimeFeaturedCollectionViewCell
        cell.setPoster(poster: (self.homeModel?.topPosters[indexPath.item])!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 && kind == UICollectionElementKindSectionHeader {
            weak var weakSelf = self
            let cell : TopPostersCollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: TopPostersCollectionElementCell, for: indexPath as IndexPath) as! TopPostersCollectionReusableView
            cell.posters = self.homeModel?.topPosters
            cell.searchButtonText = self.homeModel?.searchBarDescribe
            cell.pageIndex = pageIndex
            cell.timerScrollView.timerDelegate = self
            cell.searchButton.handle {
                weakSelf?.searchButtonAction()
            }
            return cell
        }else if kind == UICollectionElementKindSectionHeader{
            let view : UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CollectionElementKindHeaderClass, for: indexPath as IndexPath)
            return view
        }else{
            let view : UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: CollectionElementKindFooterClass, for: indexPath as IndexPath)
            return view
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            if indexPath.item == 0 || indexPath.item == 2{
                return CGSize.init(width: KScreenWidth, height: 45.0)
            }else{
                return CGSize.init(width: KScreenWidth, height: 225)
            }
        }else if indexPath.section == 1 {
            return indexPath.item == 0 ? CGSize.init(width: KScreenWidth, height: 45) : CGSize.init(width: KScreenWidth, height: 325.0)
        }else if indexPath.section == 2 {
            let width : Int = Int(KScreenWidth / 4)
            return (indexPath.item + 1) % 4 != 0 ? CGSize.init(width: CGFloat(width), height: 115.0) : CGSize.init(width: KScreenWidth - CGFloat(3 * width), height: 115.0)
        }else if indexPath.section == 3 {
            return CGSize.init(width: KScreenWidth, height: 105.0)
        }
        
        return CGSize.init(width: KScreenWidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.init(width: KScreenWidth, height: 168.0)
        }else{
            return CGSize.init(width: KScreenWidth, height: 10.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: KScreenWidth, height: 0.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func searchButtonAction(){
        print("搜索")
    }
    
    func scrollToIndexOfPage(index:Int,category:TimerScrollViewCategory){
        switch category {
        case .TopPosterCategory:
            pageIndex = index
            break
        case .AdvListPosterCategory:
            advListPageIndex = index
            break
        }
        
    }
    
    func tapActionIndexOfPage(index:Int,category:TimerScrollViewCategory){
        switch category {
        case .TopPosterCategory:
            print("这里是最顶部轮播图")
            let topPster = self.homeModel?.topPosters[index]
            let posterVC = PosterDetailViewController(nibName: "PosterDetailViewController", bundle: nil)
            posterVC.url = (topPster!.gotoPage?.url)!
            self.navigationController?.pushViewController(posterVC, animated: true)

            break
        case .AdvListPosterCategory:
            print("这里是广告位轮播图")
            break
        
        }
            }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("正在滑动，偏移量：\(scrollView.contentOffset.y)")
        let alpha = scrollView.contentOffset.y / 64.0;
        let color = UIColor(colorLiteralRed: 32.0/255.0, green: 131.0/255.0, blue: 198.0/255.0, alpha: Float(alpha))
        self.navigationController?.navigationBar.qdz_setBackgroundColor(backgroundColor: color)
        self.navigationController?.navigationBar.qdz_setElementsAlpha(alpha: alpha)
    }
    
    
}
