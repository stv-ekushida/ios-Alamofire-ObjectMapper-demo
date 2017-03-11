//
//  ViewController.swift
//  ios-Alamofire4-demo
//
//  Created by Kushida　Eiji on 2016/12/18.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let api = GourmetSearchAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        api.loadable = self        
        api.fetch()
    }
}

//MARK:-GourmetSearchLoadable
extension ViewController: GourmetSearchLoadable{
    
    func setStatus(status: GroumetSearchStatus) {
        
        switch status {
        case .loaded(let result):
            
            result.results?.shop?.forEach {
                print($0.name, $0.genre?.name ?? "")
            }

        case .none: break
        case .noData: break
        case .error: break
        case .offline: break
        }
    }
}

