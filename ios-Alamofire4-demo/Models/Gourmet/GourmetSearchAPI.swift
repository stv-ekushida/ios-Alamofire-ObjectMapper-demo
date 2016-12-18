//
//  GourmetSearchAPI.swift
//  ios-Alamofire4-demo
//
//  Created by Kushida　Eiji on 2016/12/18.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import Foundation

final class PhotoSearchAPI {
    
    var loadable: GourmetSearchLoadable?
    
    func load() {
                
        APIClient<GourmetResponse>().gourmeSearch(
            params: GourmetSearchParamsBuilder.create()) {
                [weak self](response) -> () in
            
            switch response {
            case .Success(let result):
                
                self?.loadable?.setStatus(status: .normal, result: result)
                
            case .Failure( _):
                self?.loadable?.setStatus(status: .error, result: nil)
            }
        }
    }
    
}
