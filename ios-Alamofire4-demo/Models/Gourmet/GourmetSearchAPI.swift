//
//  GourmetSearchAPI.swift
//  ios-Alamofire4-demo
//
//  Created by Kushida　Eiji on 2016/12/18.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import ObjectMapper

final class PhotoSearchAPI {
    
    var loadable: GourmetSearchLoadable?
    
    func fetch() {
                
        let router = Router.GourmetSearch(
            GourmetSearchParamsBuilder.create()
        )
        
        APIClient().request(router: router) { [weak self] (response) in
            switch response {
            case .success(let result):
                
                if let searchResult = Mapper<GourmetResponse>().map(JSONObject: result) {
                    self?.loadable?.setStatus(status: .loaded(searchResult))
                }
                
            case .failure( _):
                self?.loadable?.setStatus(status: .error)
            }
        }
    }
    
}
