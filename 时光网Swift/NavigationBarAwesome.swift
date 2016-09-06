//
//  NavigationBarAwesome.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/8/30.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import Foundation
var overlayKey = "overlayKey"
extension UINavigationBar {
    func overlay() -> UIView? {
        return (objc_getAssociatedObject(self, &overlayKey) as? UIView)
    }
    
    func setOverlay(overlay : UIView?){
        objc_setAssociatedObject(self, &overlayKey, overlay, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    
    func qdz_setBackgroundColor(backgroundColor:UIColor){
        if self.overlay() == nil {
            self.setBackgroundImage(UIImage.init(), forBarMetrics: UIBarMetrics.Default)
            let overView = UIView.init(frame: CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)+20))
            self.setOverlay(overView)
            self.overlay()?.userInteractionEnabled = true
            self.overlay()?.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
            self.insertSubview(self.overlay()!, atIndex: 0)
        }
        self.overlay()?.backgroundColor = backgroundColor
    }
    
    func qdz_setElementsAlpha(alpha : CGFloat){
        let leftViews : NSArray? = (self.valueForKey("_leftViews") as? NSArray)
        leftViews?.enumerateObjectsUsingBlock { (view, i, stop) in
            let viewAlpha = view as! UIView
            viewAlpha.alpha = alpha;
        }
        
        let rightViews : NSArray? = self.valueForKey("_rightViews") as? NSArray
        rightViews?.enumerateObjectsUsingBlock { (view, i, stop) in
            let viewAlpha = view as! UIView
            viewAlpha.alpha = alpha;
        }
        
        let titleView : UIView? = self.valueForKey("_titleView") as? UIView
        titleView?.alpha = alpha
        
        
        let subViews = self.subviews as NSArray
        subViews.enumerateObjectsUsingBlock { (view, i, stop) in
            let viewAlpha = view as! UIView
            if viewAlpha.isKindOfClass(NSClassFromString("UINavigationItemView")!){
                viewAlpha.alpha = alpha
            }
        }
        
     }
    
    func reset() {
        self.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        self.overlay()?.removeFromSuperview()
        self.setOverlay(nil)
    }
    
}