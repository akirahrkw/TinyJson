//
//  TinyJsonTests.swift
//  TinyJsonTests
//
//  Created by Akira Hirakawa on 22/3/15.
//  Copyright (c) 2015 akira hirakawa. All rights reserved.
//

import UIKit
import XCTest

public class Media {
    var id: Int?
    var caption: String?
}

class TinyJsonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func testCall() {
        
        var mapper = { (json: Dictionary<String, AnyObject>) -> [Media] in
            
            var result = [Media]()
            
            var list = json["data"] as NSArray
            
            var array = list as NSArray
            
            for dic in array {
                let obj = Media()
                obj.id = dic["id"] as? Int
                obj.caption = dic["caption"] as? String
                
                result.append(obj)
            }
            
            return result
        }
        
        var handler = { (array: [Media]) -> () in
            for val in array {
                println(val)
            }
        }
        
        var params = [String: AnyObject]()
        params["id"] = 12
        params["title"] = "test"
        
        var url = "http://eli.lvh.me:8000/api/media"
        var request = TJRequest<[Media]>(url: url, method: .GET, jsonMapper: mapper, completionHandler: handler)
        
        var cached = TJAPI.call(request, params: params)
        println(cached)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
