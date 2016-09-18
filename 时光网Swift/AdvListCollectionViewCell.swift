//
//  AdvListCollectionViewCell.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/12.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class AdvListCollectionViewCell: UICollectionViewCell {

    var entrys : MallEntrysModel?{
        didSet{
            if entrys != nil {
                self.setNeedsLayout()
            }
        }
    }
    
    var entrysDic : NSDictionary? {
        didSet{
            if entrysDic != nil {
                self.setNeedsLayout()
            }
        }
    }
    
    @IBOutlet weak var mallEntryImageView: UIImageView!
    @IBOutlet weak var mallEntryLabel: UILabel!
    
    @IBOutlet weak var heightLayout: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        heightLayout.constant = 0.5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if entrys != nil  {
            
            return
        }
        
        if entrysDic != nil {
            let imageString : String = entrysDic!["image"] as! String
            mallEntryImageView.image = UIImage(named:imageString)
            let title : String = entrysDic!["title"] as! String
            mallEntryLabel.text = title
        }
        
    }

}
