//
//  APIClient.swift
//  ios-Alamofire4-demo
//
//  Created by Kushida　Eiji on 2016/12/18.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import Alamofire
import ObjectMapper

final class APIClient<T> {
    
    func gourmeSearch(params : [String: Any],
                      completionHandler: @escaping (Result<T>) -> () = {_ in}) {
                
        Alamofire.request(Router.GourmetSearch(params)).responseJSON  { response in
            switch response.result {
            case .success(let value):
                if let resp = Mapper<GourmetResponse>().map(JSONObject: value) {
                    completionHandler(Result<T>.Success((resp as? T)!))
                }
                break
                
            case .failure:
                completionHandler(Result<T>.Failure(response.result.error!))
                break
            }
        }
    }
}
