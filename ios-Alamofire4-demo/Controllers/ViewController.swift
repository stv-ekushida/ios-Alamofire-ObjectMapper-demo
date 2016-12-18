//
//  ViewController.swift
//  ios-Alamofire4-demo
//
//  Created by Kushida　Eiji on 2016/12/18.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let api = PhotoSearchAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        api.loadable = self        
        api.load()
    }
}

//MARK:-GourmetSearchLoadable
extension ViewController: GourmetSearchLoadable{
    
    func setStatus(status: GroumetSearchStatus,
                   result: GourmetResponse?) {
        
        switch status {
        case .normal:
            
            result?.results?.shop?.forEach {
                print($0.name, $0.genre?.name ?? "")
            }
            break
        default:
            break
        }
    }
}

