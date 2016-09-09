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
    @IBOutlet weak var bottomHeightLayout: NSLayoutConstraint!
    
    var comingMoviewText : String?
    var cinemasText : String?
    var comingMovieValue : Int? = 0{
        didSet{
            if comingMovieValue != nil {
                comingMoviewText = "即将上映·\(comingMovieValue!)部"
            }
        }
    }
    
    var cinemas : Int? = 0{
        didSet{
            if cinemas != nil {
                cinemasText = "同城影院·\(cinemas!)家"
                self.setNeedsLayout()
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        heightLayout.constant = 0.5
        bottomHeightLayout.constant = 0.5
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if comingMoviewText != nil {
            comingMovieButton.setTitle(comingMoviewText!, forState: UIControlState.Normal)
        }
        
        if cinemasText != nil {
            cinemasButton.setTitle(cinemasText!, forState: UIControlState.Normal)
        }
    }
    
    
}
