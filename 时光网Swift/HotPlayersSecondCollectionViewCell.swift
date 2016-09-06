//
//  HotPlayersSecondCollectionViewCell.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/5.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class HotPlayersSecondCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var comingMovieButton: UIButton!
    @IBOutlet weak var cinemasButton: UIButton!
    @IBOutlet weak var heightLayout: NSLayoutConstraint!
    
    var comingMoviewText : String?
    var cinemasText : String?
    var comingMovieValue : Int?{
        didSet{
            comingMoviewText = "即将上映·\(comingMovieValue!)部"
        }
    }
    
    var cinemas : Int?{
        didSet{
            cinemasText = "同城影院·\(cinemas!)家"
            self.setNeedsLayout()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        heightLayout.constant = 0.5
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        comingMovieButton.setTitle(comingMoviewText!, forState: UIControlState.Normal)
        cinemasButton.setTitle(cinemasText!, forState: UIControlState.Normal)
    }
    
    
}
