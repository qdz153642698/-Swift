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
            static let instance : SGNetWorkManager = SGNetWorkManager()
        }
        return Static.instance
    }
    
    func getDataTaskWithURL_params_completion(url:String,params:NSDictionary,successCompletion:((_ json:NSDictionary) -> Void)?,errorCompletion:((_ error:NSError) -> Void)?) {
        var json : NSDictionary = [:]
        let manager = AFURLSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        let URL = NSURL(string: url)
        let request = NSURLRequest(url: URL! as URL)
        let dataTask = manager.dataTask(with: request as URLRequest) { (response, responseObject, error) -> Void in
            if error != nil {
                if errorCompletion != nil {
                    errorCompletion!(error! as NSError)
                }
            }else {
                json = (responseObject as? NSDictionary)!
                if successCompletion != nil {
                    successCompletion!(json as NSDictionary)
                }
            }
            
        }
        dataTask.resume()
    }
    
    
}
