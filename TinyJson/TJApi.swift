//
//  TJApi.swift
//  TinyJson
//
//  Created by Akira Hirakawa on 22/3/15.
//  Copyright (c) 2015 akira hirakawa. All rights reserved.
//

import UIKit

public class TJAPI {

    public class func call<T>(request: TJRequest<T>, params: [String: AnyObject]?, cache: TJCache?) -> T? {
        
        var url = request.url
        var mutableParams = params
        
        if mutableParams != nil {
            url = mutableParams!.urlMapping(url)
            
            if request.method == .GET || request.method == .DELETE {
                url = url + "?" + mutableParams!.urlEncodedString()
            }
        }
        
        var req = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: 30.0)
        req.HTTPMethod = request.method.rawValue
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if(request.method == .POST || request.method == .PUT) {
            req.HTTPBody = mutableParams?.urlEncodedString().dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        }
        
        var session = NSURLSession.sharedSession()
        var closure = { (data:NSData!, response:NSURLResponse!, error:NSError!) -> () in
            
            var serializeError: NSError?;
            let obj = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: nil) as Dictionary<String, AnyObject>
            
            if error == nil {
                
                if serializeError == nil {
                    
                    let object: T = request.mapper(obj)
                    
                    let httpRes = response as NSHTTPURLResponse
                    
                    if httpRes.statusCode >= 200 && httpRes.statusCode < 300 {
                        
                        cache?.save(request, params: params, object: object)
                        request.completionHandler?(object)
                    } else {
                        
                        // Http status error
                        request.errorHandler?(obj, error)
                    }
                    
                } else {
                    
                    // NSJSONSerialization error
                    request.errorHandler?(obj, serializeError!)
                }
                
            } else {
                
                // Request error
                request.errorHandler?(obj, error)
            }
        }
        
        var task = session.dataTaskWithRequest(req, completionHandler: closure)
        task.resume()
        
        var cached: T? = cache?.fetch(request, params: params)
        
        return cached
    }
    
    public class func call<T>(request: TJRequest<T>, params: [String: AnyObject]?) -> T? {
        return self.call(request, params: params, cache: nil)
    }
}
