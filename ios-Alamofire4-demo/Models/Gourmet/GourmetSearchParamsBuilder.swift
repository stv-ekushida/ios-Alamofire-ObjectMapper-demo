//
//  GourmetSearchParamsBuilder.swift
//  ios-Alamofire4-demo
//
//  Created by Kushida　Eiji on 2016/12/18.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import UIKit

final class GourmetSearchParamsBuilder {
    
    static let perPage = 50
    
    static func create() -> [String: Any]{
        
        let params = [
            "service_area":"SA11", //東京
            "key": "807d67c3e869ca06",
            "format": "json",
            "count" : "\(perPage)"
        ]
        return params
    }
}
