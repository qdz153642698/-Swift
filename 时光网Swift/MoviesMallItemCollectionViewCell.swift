//
//  MoviesMallItemCollectionViewCell.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/9.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class MoviesMallItemCollectionViewCell: UICollectionViewCell {

    var mallArray : [RecommendModel]?{
        didSet{
            if mallArray != nil {
                self.setNeedsLayout()
            }
        }
    }
    @IBOutlet weak var firstLineLayout: NSLayoutConstraint!
    @IBOutlet weak var secondLineLayout: NSLayoutConstraint!
    @IBOutlet weak var thirdLineLayout: NSLayoutConstraint!
    @IBOutlet weak var fourthLineLayout: NSLayoutConstraint!
    @IBOutlet weak var fifthLineLayout: NSLayoutConstraint!
    @IBOutlet weak var sixthLineLayout: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstLineLayout.constant = 0.5
        secondLineLayout.constant = 0.5
        thirdLineLayout.constant = 0.5
        fourthLineLayout.constant = 0.5
        fifthLineLayout.constant = 0.5
        sixthLineLayout.constant = 0.5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for recommend in mallArray ?? [RecommendModel]() {
            let position = recommend.position
            let mallImageView = self.viewWithTag(position) as? UIImageView
            if mallImageView != nil {
                let url : NSURL = NSURL.init(string: recommend.image)!
                mallImageView?.sd_setImage(with: url as URL?!)
            }
            
            let title = self.viewWithTag(position + 10) as? UILabel
            if title != nil {
                title?.text = recommend.title
                title?.textColor = recommend.color
            }
            
            let titleSmall = self.viewWithTag(position + 20) as? UILabel
            if titleSmall != nil {
                titleSmall?.text = recommend.titleSmall
            }
            
        }
    }

}
