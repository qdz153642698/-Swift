//
//  QDZHorizontalScrollView.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/5.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class QDZHorizontalScrollView: UIView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    let HotPlayersItemCollectionCell = "HotPlayersItemCollectionCell"
    var collectionView: UICollectionView?
    var itemSize : CGSize?{
        didSet{
            
            
        }
    }
    var hotMovies : [HotMovieModel]?{
        didSet{
            configCollectionView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configCollectionView(){
        if collectionView == nil {
            let flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
            flowLayout.minimumLineSpacing = 10
            flowLayout.minimumInteritemSpacing = 0.0
            flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
            flowLayout.itemSize = itemSize!
            flowLayout.footerReferenceSize = CGSizeMake(10, CGRectGetHeight(self.frame))
            flowLayout.headerReferenceSize = CGSizeMake(10, CGRectGetHeight(self.frame))
            collectionView = UICollectionView.init(frame: CGRectMake(0, 0, KScreenWidth, itemSize!.height), collectionViewLayout: flowLayout)
            collectionView!.showsVerticalScrollIndicator = false
            collectionView!.showsHorizontalScrollIndicator = false
            collectionView!.alwaysBounceHorizontal = true
            collectionView!.delegate = self
            collectionView!.dataSource = self
            collectionView!.backgroundColor = UIColor.whiteColor()
            let nib : UINib = UINib.init(nibName: "HotPlayersItemCollectionViewCell", bundle: nil)
            collectionView!.registerNib(nib, forCellWithReuseIdentifier: HotPlayersItemCollectionCell)
            self.addSubview(collectionView!)
            self.collectionView?.reloadData()
        }
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (hotMovies?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : HotPlayersItemCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(HotPlayersItemCollectionCell, forIndexPath: indexPath) as! HotPlayersItemCollectionViewCell
        cell.movie = self.hotMovies?[indexPath.item]
        return cell
    }

}
