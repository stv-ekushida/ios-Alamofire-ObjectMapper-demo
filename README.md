# ios-Alamofire-ObjectMapper-demo

## 1. PodFile

```
    pod 'Alamofire', '~> 4.2'
    pod 'ObjectMapper', '~> 2.2'
```

## 2. import する
```
import Alamofire
import ObjectMapper
```

## 3. EndPointの設定

```
import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = "http://webservice.recruit.co.jp/hotpepper"
    
    case GourmetSearch([String: Any])
    
    func asURLRequest() throws -> URLRequest {
        
        let (method, path, parameters): (HTTPMethod, String, [String: Any]) = {
            
            switch self {
            case .GourmetSearch(let params):
                return (.get, "gourmet/v1/", params)
            }
        }()
        
        let url = URL(string: Router.baseURLString)
        var urlRequest = URLRequest(url: url!.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
```
## 4. 専用APIのHelperの作成

```
import ObjectMapper

enum GroumetSearchStatus {
    case none
    case noData
    case loaded(GourmetResponse)
    case offline
    case error
}

protocol GourmetSearchLoadable{
    func setStatus(status: GroumetSearchStatus)
}

final class GourmetSearchAPI {
    
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

```

## 5. 使い方

```
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

```

## 参考
インフラ部分は、下記のとおりです。

```
import Alamofire

enum Result {
    case success(Any)
    case failure(Error)
}

final class APIClient {
    
    func request(router : Router,
                 completionHandler: @escaping (Result) -> () = {_ in}) {
        
        Alamofire.request(router).responseJSON  { response in
            switch response.result {
            case .success(let value):
                completionHandler(Result.success(value))
                
            case .failure:
                
                if let error = response.result.error {
                    completionHandler(Result.failure(error))
                } else {
                    fatalError("エラーのインスタンスがnil")
                }
            }
        }
    }
}

```

## 環境

|category | Version| 
|---|---|
| Swift | 3.0 |
| XCode | 8.1 |
| Cocoa Pods | 1.1.1 |
| iOS | 10.0〜 |

##OSS 

|OSS name | Version| 
|---|---|
| Alamofire | 4.2 |
| ObjectMapper | 2.2 |
