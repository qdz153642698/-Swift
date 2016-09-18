//
//  TimerScrollView.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/4/20.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

enum TimerScrollViewCategory : Int{
    case TopPosterCategory = 1
    case AdvListPosterCategory
}

protocol TimerScrollViewDelegate {
    func scrollToIndexOfPage(index:Int,category:TimerScrollViewCategory)
    func tapActionIndexOfPage(index:Int,category:TimerScrollViewCategory)
}

class TimerScrollView: UIView,UIScrollViewDelegate {
    var count : Int = 0
    var timer : Timer!
    var timerDelegate:TimerScrollViewDelegate?
    var scrollView : UIScrollView?
    var pageCT : UIPageControl?
    var category : TimerScrollViewCategory = TimerScrollViewCategory.TopPosterCategory
    /*
    params:
        array : 图片URL集合
        contentOffSetIndex : 偏移位置
    */
    func configScrollView(array:NSArray,contentOffsetIndex:Int,scrollViewCategory : TimerScrollViewCategory){
        count = array.count
        category = scrollViewCategory
        
        self.clipsToBounds = false
        self.backgroundColor = UIColor.white
        
        scrollView = UIScrollView(frame: self.bounds)
        scrollView!.delegate = self
        scrollView?.backgroundColor = UIColor.green
        scrollView!.contentSize = CGSize.init(width: CGFloat(array.count+2) * self.frame.size.width, height: self.frame.size.height)
        scrollView!.isPagingEnabled = true
        scrollView!.showsHorizontalScrollIndicator = false
        scrollView!.showsVerticalScrollIndicator = false
        self.addSubview(scrollView!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(tap:)))
        scrollView?.addGestureRecognizer(tap)
        
        createImageViews(array: array,contentOffsetIndex:contentOffsetIndex)
        configPageControll(currentPage: contentOffsetIndex)

        timerBegin()
    }
    
    func createImageViews(array:NSArray,contentOffsetIndex:Int){
        for i in 0 ..< array.count+2{
            var url : String!
            if i == 0 {
                url = array[array.count-1] as! String
            }else if i == array.count + 1 {
                url = array[0] as! String
            }else {
                url = array[i-1] as! String
            }
            
            
            let URL : NSURL = NSURL(string: url)!
            let imageView = UIImageView(frame: CGRect.init(x: CGFloat(i)*self.frame.size.width, y: 0, width: self.frame.size.width, height: self.frame.size.height))
            //图片的加载需要依赖于框架，
            imageView.sd_setImage(with: URL as URL!)
            scrollView!.addSubview(imageView)
        }
        
        scrollView!.contentOffset = CGPoint.init(x: CGFloat(contentOffsetIndex+1)*self.frame.size.width, y: 0)
    }
    
    func configPageControll(currentPage:Int) {
        pageCT = UIPageControl(frame: CGRect.init(x: 0, y: self.frame.size.height-(category==TimerScrollViewCategory.TopPosterCategory ? 36.0 : 0)-15, width: self.frame.size.width, height: 15))
        pageCT!.pageIndicatorTintColor = UIColor.gray
        pageCT!.currentPageIndicatorTintColor = UIColor.white
        pageCT!.numberOfPages = count
        pageCT!.currentPage = currentPage
        self.addSubview(pageCT!)
    }
    
    //开启
    func timerBegin() {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
        
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(timerRun(runTimer:)), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    //暂停
    func timerSuspend() {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    
    func timerRun(runTimer:Timer) {
        let offsetX = scrollView!.contentOffset.x
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
                self.scrollView!.contentOffset = CGPoint.init(x: offsetX+self.frame.size.width, y: 0)
            }) { (boolValue:Bool) -> Void in
                self.resetContentOffset()
        }
        
    }
    
    func resetTimerScrollView(){
        for obj in self.subviews{
            obj.removeFromSuperview()
        }
        timerSuspend()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timerSuspend()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timerBegin()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        resetContentOffset()
    }
    
    func resetContentOffset(){
        if scrollView!.contentOffset.x < self.frame.size.width {
            scrollView!.contentOffset = CGPoint.init(x: self.frame.size.width*CGFloat(count), y: 0)
        }
        
        if scrollView!.contentOffset.x > self.frame.size.width * CGFloat(count) {
            scrollView!.contentOffset = CGPoint.init(x: self.frame.size.width, y: 0)
        }
        
        
        let vc = self.timerDelegate as! UIViewController
//        if vc.respondsToSelector(Selector("scrollToIndexOfPage:category:")) {
            let index = Int((scrollView!.contentOffset.x - self.frame.size.width) / self.frame.size.width)
            pageCT?.currentPage = index
            timerDelegate?.scrollToIndexOfPage(index: index,category: category)
//        }
    }
    
    
    func tapAction(tap:UITapGestureRecognizer){
        let vc = self.timerDelegate as! UIViewController
//        if vc.respondsToSelector(Selector("scrollToIndexOfPage:category:")) {
            let index = Int((scrollView!.contentOffset.x - self.frame.size.width) / self.frame.size.width)
            timerDelegate?.tapActionIndexOfPage(index: index,category: category)
//        }
        
    }
    
}
