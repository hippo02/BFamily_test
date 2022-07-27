//
//  BFNetwork.swift
//  BF_Test
//
//  Created by mino on 2022/07/27.
//

import UIKit
import Alamofire
import ObjectMapper

class BFNetwork {
    
    class func request(_ url: URLConvertible, parameters: [String: Any]?, responseHandler: @escaping (BFNetworkResult?) -> Void) {
        
        guard let url = try? url.asURL() else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        AF.request(urlRequest)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                if let error = response.error {
                    print(error)
                    responseHandler(nil)
                    return
                }
                
                switch response.result {
                case .success(let value):
                    if let result = try? BFNetworkResult(JSONObject: value) {
                        responseHandler(result)
                    }
                case .failure(let error):
                    print("error : \(error)")
                    responseHandler(nil)
                }
        }
    }
}

struct BFNetworkResult: ImmutableMappable {
    
    let resultCode: String?
    let resultData: [String: Any]
    
    init(map: Map) throws {
        resultCode = try? map.value("code")
        resultData = map.JSON
    }
}
