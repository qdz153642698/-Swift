//
//  HotPlayersCollectionViewCell.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/5.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class HotPlayersCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var qdzHorizontalScrollView: QDZHorizontalScrollView!
    var hotMovies : [HotMovieModel]?{
        didSet{
            self.setNeedsLayout()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        qdzHorizontalScrollView.itemSize = CGSize.init(width: 104, height: 225)
        qdzHorizontalScrollView.hotMovies = hotMovies
    }
    
}
