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
            self.setBackgroundImage(UIImage.init(), for: UIBarMetrics.default)
            let overView = UIView.init(frame: CGRect.init(x: 0, y: -20, width: self.bounds.width, height: self.bounds.height+20))
            self.setOverlay(overlay: overView)
            self.overlay()?.isUserInteractionEnabled = true
            self.overlay()?.autoresizingMask = [UIViewAutoresizing.flexibleWidth , UIViewAutoresizing.flexibleHeight]
            self.insertSubview(self.overlay()!, at: 0)
        }
        self.overlay()?.backgroundColor = backgroundColor
    }
    
    func qdz_setElementsAlpha(alpha : CGFloat){
        let leftViews : NSArray? = (self.value(forKey: "_leftViews") as? NSArray)
        leftViews?.enumerateObjects({ (view, i, stop) in
            let viewAlpha = view as! UIView
            viewAlpha.alpha = alpha;
        })
        
        let rightViews : NSArray? = self.value(forKey: "_rightViews") as? NSArray
        rightViews?.enumerateObjects({ (view, i, stop) in
            let viewAlpha = view as! UIView
            viewAlpha.alpha = alpha;
        })
        
        let titleView : UIView? = self.value(forKey: "_titleView") as? UIView
        titleView?.alpha = alpha
        
        
        let subViews = self.subviews as NSArray
        subViews.enumerateObjects({ (view, i, stop) in
            let viewAlpha = view as! UIView
            if viewAlpha.isKind(of: NSClassFromString("UINavigationItemView")!) {
                viewAlpha.alpha = alpha
            }
        })
     }
    
    func reset() {
        self.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.overlay()?.removeFromSuperview()
        self.setOverlay(overlay: nil)
    }
    
}
