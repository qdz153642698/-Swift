//
//  SalingTicketsCollectionViewCell.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/2.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class SalingTicketsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var salingCityButton: UIButton!
    @IBOutlet weak var moviesButton: UIButton!
    var baseSalingCityButton : String?
    var movieButtonTitle : String?
    var cityName : String?{
        didSet{
            baseSalingCityButton = "正在售票·\(cityName!)"
        }
    }
    
    var movies : Int?{
        didSet{
            movieButtonTitle = "共\(movies!)部"
            self.setNeedsLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //正在售票·北京
        salingCityButton.setTitle(baseSalingCityButton! as String, forState: UIControlState.Normal)
        
        //共50部门
        moviesButton.setTitle(String(movieButtonTitle!), forState: UIControlState.Normal)
        
    }

}
