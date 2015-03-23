//
//  Extension.swift
//  TinyJson
//
//  Created by Akira Hirakawa on 22/3/15.
//  Copyright (c) 2015 akira hirakawa. All rights reserved.
//

import Foundation

extension String {
    
    func urlEncode() -> String! {
        let str = self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        return (str != nil) ? str : ""
    }
}

extension Dictionary {
    
    func urlEncodedString() -> String {
        
        var params = [String]()
        
        for (key, value) in self {
            let v = "\(value)".urlEncode()
            params.append("\(key)=\(v)")
        }
        
        return "&".join(params)
    }
    
    mutating func urlMapping(url: String) -> String {
        
        var mappedUrl = url
        for (key, value) in self {
            let found = url.stringByReplacingOccurrencesOfString(":\(key)", withString: "\(value)", options: nil, range: nil)
            if found != url {
                mappedUrl = found
                self.removeValueForKey(key)
            }
        }
        
        return mappedUrl
    }
}