//
//  AdvListTimerForScrollCollectionViewCell.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/12.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit
class AdvListTimerForScrollCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var advScrollView: TimerScrollView!
    
    var posters : [TopPoster]?{
        didSet{
            if posters != nil {
                self.setNeedsLayout()
            }
        }
    }
    
    var pageIndex : Int = 0{
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //如果不加这一句，下面获取到的frame是autoLayout没有完成时的frame。
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
        
//        advScrollView.frame = self.bounds
        advScrollView.resetTimerScrollView()
        
        var imgUrlArray = [String]()
        for poster in posters ?? [TopPoster]() {
            imgUrlArray.append(poster.img!)
        }
        
        if imgUrlArray.count >= 1 {
            advScrollView!.configScrollView(array: imgUrlArray as NSArray,contentOffsetIndex: pageIndex,scrollViewCategory:TimerScrollViewCategory.AdvListPosterCategory)
        }
        
    }

}
