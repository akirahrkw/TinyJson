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
    
    func testPerformanceExample() {
        self.measureBlock() {
            self.mediaAPI()
        }
    }
    
    func mediaAPI() {
        
        //// Object Mapper
        var mapper = { (json: AnyObject) -> [Media] in
            
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
        
        /// completionHandler
        var handler = { (array: [Media], params: [String: AnyObject]?) -> () in
            
            for val in array {
                println(val.caption)
            }
        }
        
        var url = "http://eli.lvh.me:8000/api/media"
        var request = TJRequest<[Media]>(url: url, method: .GET, jsonMapper: mapper, completionHandler: handler)
        
        TJAPI.call(request, params: nil)
    }

}
