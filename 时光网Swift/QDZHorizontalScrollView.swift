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
            if hotMovies != nil {
                configCollectionView()
            }
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
            flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
            flowLayout.itemSize = itemSize!
            flowLayout.footerReferenceSize = CGSize.init(width: 10, height: self.frame.height)
            flowLayout.headerReferenceSize = CGSize.init(width: 10, height: self.frame.height)
            collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: itemSize!.height), collectionViewLayout: flowLayout)
            collectionView!.showsVerticalScrollIndicator = false
            collectionView!.showsHorizontalScrollIndicator = false
            collectionView!.alwaysBounceHorizontal = true
            collectionView!.delegate = self
            collectionView!.dataSource = self
            collectionView!.backgroundColor = UIColor.white
            let nib : UINib = UINib.init(nibName: "HotPlayersItemCollectionViewCell", bundle: nil)
            collectionView!.register(nib, forCellWithReuseIdentifier: HotPlayersItemCollectionCell)
            self.addSubview(collectionView!)
            self.collectionView?.reloadData()
        }
    }
    
    
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (hotMovies?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HotPlayersItemCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HotPlayersItemCollectionCell, for: indexPath as IndexPath) as! HotPlayersItemCollectionViewCell
        cell.movie = self.hotMovies?[indexPath.item]
        return cell
    }

}
