//
//  SGNetWorkManager.swift
//  时光网Swift
//
//  Created by 亓大志 on 16/4/25.
//  Copyright © 2016年 亓大志. All rights reserved.
//

import UIKit

class SGNetWorkManager: NSObject {
    class var shareInstance:SGNetWorkManager {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : SGNetWorkManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = SGNetWorkManager()
        }
        return Static.instance!
    }
    
    func getDataTaskWithURL_params_completion(url:String,params:NSDictionary,successCompletion:((json:NSDictionary) -> Void)?,errorCompletion:((error:NSError) -> Void)?) {
        var json : NSDictionary = [:]
        let manager = AFURLSessionManager(sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let URL = NSURL(string: url)
        let request = NSURLRequest(URL: URL!)
        let dataTask = manager.dataTaskWithRequest(request) { (response, responseObject, error) -> Void in
            if error != nil {
                if errorCompletion != nil {
                    errorCompletion!(error:error!)
                }
            }else {
                json = (responseObject as? NSDictionary)!
                if successCompletion != nil {
                    successCompletion!(json: json)
                }
            }
            
        }
        dataTask.resume()
    }
    
    
}
