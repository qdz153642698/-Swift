//
//  MoviesMallCollectionViewCell.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/9.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class MoviesMallCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var heightLayout: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        heightLayout.constant = 0.5
    }

}

