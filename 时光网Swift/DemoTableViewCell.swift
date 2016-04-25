//
//  DemoTableViewCell.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/4/20.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class DemoTableViewCell: UITableViewCell {

    @IBOutlet weak var showImageView: UIImageView!
    
    var topPoster : TopPoster?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clearColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setPoster(poster:TopPoster){
        self.topPoster = poster
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
//        let url = self.topPoster!.img!
//        let URL : NSURL = NSURL(string: url)!
//        self.showImageView.sd_setImageWithURL(URL, placeholderImage: UIImage(named: "lead_bg_logo"))
    }
    
}
