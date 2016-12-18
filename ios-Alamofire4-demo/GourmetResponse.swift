//
//  GourmetResponse.swift
//  ios-Alamofire4-demo
//
//  Created by Kushida　Eiji on 2016/12/18.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import ObjectMapper

struct GourmetResponse: Mappable {
    
    var results: GourmetResults?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        results <- map["results"]
    }
}

struct GourmetResults: Mappable {
    
    var results_available = ""
    var results_returned =  ""
    var results_start =  0
    var shop: [GourmetShop]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        results_available <- map["results_available"]
        results_returned <- map["results_available"]
        results_start <- map["results_start"]
        shop <- map["shop"]
    }
}

struct GourmetShop: Mappable {
    
    var name = ""
    var results_returned =  ""
    var results_start =  0
    var genre: GourmetShopGenre?
    var food: GourmetShopFood?
    var open = ""
    var close = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        results_returned <- map["results_available"]
        results_start <- map["results_start"]
        genre <- map["genre"]
        open <- map["open"]
        close <- map["close"]
    }
}

struct GourmetShopGenre: Mappable{

    var catchName = ""
    var code = ""
    var name = ""

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        catchName <- map["catch"]
        code <- map["code"]
        name <- map["name"]
    }
}

struct GourmetShopFood: Mappable{
    var code = ""
    var name = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        code <- map["code"]
        name <- map["name"]
    }
}
