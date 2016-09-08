//
//  HotPlayersItemCollectionViewCell.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/5.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class HotPlayersItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var buyTicketButton: UIButton!
    
    @IBOutlet weak var sysbolImageView: UIImageView!
    @IBOutlet weak var movie3DType: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var movie : HotMovieModel!{
        didSet{
            self.setNeedsLayout()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buyTicketButton.setBackgroundImage(UIImage(named: "bt_solid_orange_66"), forState: UIControlState.Normal)
        buyTicketButton.layer.cornerRadius = CGRectGetHeight(buyTicketButton.bounds) / 2.0
        buyTicketButton.layer.masksToBounds = true
        
        movie3DType.backgroundColor = ColorWithRGB(r: 8, g: 195, b: 240, alpha: 1)
        ratingLabel.backgroundColor = ColorWithRGB(r: 105, g: 174, b: 0, alpha: 1)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if movie?.img != nil {
            let url : NSURL = NSURL.init(string: movie!.img!)!
            movieImageView.sd_setImageWithURL(url)
        }
        movieNameLabel.text = "\(movie!.titleCn!)"
        
        //new 标志
        if movie!.isTodayMovie == true {
            sysbolImageView.image = UIImage(named: "low_new_tag")
            sysbolImageView.hidden = false
        }else if movie!.isNew == true{
            sysbolImageView.image = UIImage(named: "img_home_new")
            sysbolImageView.hidden = false
        }else{
            sysbolImageView.hidden = true
        }
        
        //3D 标志
        if movie?.is3D == true || movie?.isDMAX == true || movie?.isIMAX == true || movie?.isIMAX3D == true{
            movie3DType.hidden = false
            if movie?.isIMAX3D == true {
                movie3DType.text = " IMAX 3D "
            }else if movie?.isIMAX == true{
                movie3DType.text = " IMAX "
            }else if movie?.isDMAX == true{
                movie3DType.text = " DMAX "
            }else if movie?.is3D == true{
                movie3DType.text = " 3D "
            }
        }else{
            movie3DType.hidden = true
        }
        //评分
        /*
         7.6   6.7   6.4   7.9   6.4    7    5.7   6.3   6.1    -1    7. 2    7.7    5   5.7   7.1
         */
        if movie!.ratingFinal! >= 0 {
            ratingLabel.hidden = false
            ratingLabel.text = "\(movie!.ratingFinal!)"
        }else{
            ratingLabel.hidden = true
        }
        
        //购票按钮
        if movie!.isAdvanceBooking == true {
            buyTicketButton.setBackgroundImage(UIImage(named:"bt_solid_green_66"), forState: UIControlState.Normal)
            buyTicketButton.setTitle("预售", forState: UIControlState.Normal)
        }else{
            buyTicketButton.setBackgroundImage(UIImage(named:"bt_solid_orange_66"), forState: UIControlState.Normal)
            buyTicketButton.setTitle("购票", forState: UIControlState.Normal)
        }
        
    }

}
