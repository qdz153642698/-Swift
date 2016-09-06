//
//  TimeFeaturedCollectionViewCell.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/1.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class TimeFeaturedCollectionViewCell: UICollectionViewCell {
    
    var topPoster : TopPoster?
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setPoster(poster:TopPoster) -> Void {
        self.topPoster = poster
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let url : NSURL = NSURL.init(string: (self.topPoster?.img)!)!
        self.posterImageView.sd_setImageWithURL(url)
    }
    
    

}
