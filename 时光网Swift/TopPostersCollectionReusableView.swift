//
//  TopPostersCollectionReusableView.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/9/1.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class TopPostersCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var timerScrollView: TimerScrollView!
    @IBOutlet weak var searchButton: UIButton!
    var posters : [TopPoster]?{
        didSet{
            if posters != nil {
                self.setNeedsLayout()
            }
        }
    }
    
    var searchButtonText : String? = ""{
        didSet{
            self.setNeedsLayout()
        }
    }
    
    var pageIndex : Int = 0{
        didSet{
            self.setNeedsLayout()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.searchButton.layer.cornerRadius = self.searchButton.frame.size.height / 2.0
        self.searchButton.layer.masksToBounds = true
        self.searchButton.layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1).CGColor
        self.searchButton.layer.borderWidth = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.searchButton.setTitle(searchButtonText, forState: UIControlState.Normal)
        timerScrollView.resetTimerScrollView()
        
        var imgUrlArray = [String]()
        for poster in posters ?? [TopPoster]() {
            imgUrlArray.append(poster.img!)
        }
        
        if imgUrlArray.count >= 1 {
            timerScrollView!.configScrollView(imgUrlArray,contentOffsetIndex: pageIndex)
        }
    }
    
    //解决 当UIView上面的UIButton超出UIView的范围时，UIButton点击范围问题
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let result = super.hitTest(point, withEvent: event)
        for sub in self.subviews {
            if sub is UIButton {
                let button = sub as! UIButton
                let buttonPoint = button.convertPoint(point, fromView: self)
                if button.pointInside(buttonPoint, withEvent: event) {
                    return button
                }
            }
        }
        return result
    }
}
