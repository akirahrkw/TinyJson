//
//  TinyJsonRequest.swift
//  TinyJson
//
//  Created by Akira Hirakawa on 22/3/15.
//  Copyright (c) 2015 akira hirakawa. All rights reserved.
//

import Foundation

public enum TJHttpMethod : String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

public protocol TJCache {
    
    func fetch<T>(url: TJRequest<T>, params: [String: AnyObject]?) -> T?
    
    func save<T>(url: TJRequest<T>, params: [String: AnyObject]?, object: T) -> Bool
    
    func remove<T>(url: TJRequest<T>, params: [String: AnyObject]?) -> Bool
}

public class TJRequest<T>: NSObject {

    var method: TJHttpMethod
    var url: String
    var mapper: (Dictionary<String, AnyObject>) -> T
    var completionHandler: ((T) -> ())?
    var errorHandler: ((Dictionary<String, AnyObject>, NSError) -> ())?

    public init(url: String, method: TJHttpMethod, jsonMapper: (Dictionary<String, AnyObject>) -> T, completionHandler: (T) -> (), errorHandler: ((Dictionary<String, AnyObject>, NSError) -> ())?) {
        
        self.url = url
        self.method = method
        self.mapper = jsonMapper
        self.completionHandler = completionHandler
        self.errorHandler = errorHandler
    }
    
    public convenience init(url: String, method: TJHttpMethod, jsonMapper: (Dictionary<String, AnyObject>) -> T, completionHandler: (T) -> ()){
        
        self.init(url: url, method: method, jsonMapper: jsonMapper, completionHandler: completionHandler, errorHandler: nil)
    }
}
