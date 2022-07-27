//
//  Home.swift
//  BF_Test
//
//  Created by mino on 2022/07/27.
//

import ObjectMapper

struct Home {
    
    struct list: ImmutableMappable {
        let screenshotUrls: [String]?
        let description: String
        
        init(map: Map) throws {
            screenshotUrls = try? map.value("screenshotUrls")
            description = (try? map.value("description")) ?? ""
        }
    }

}

extension Home {
    static func loadHome(_ handler: @escaping ([list]?) -> Void) {

        let url = URL(string: "https://itunes.apple.com/kr/lookup?id=1502953604")!
        
        BFNetwork.request(url, parameters: nil) {
            guard let result = $0 else {
                print("Network Error")
                handler(nil)
                return
            }
            
            guard let data = result.resultData["results"] as? [[String: Any]] else {
                handler(nil)
                return
            }

            
            let lists = try? Mapper<list>().mapArray(JSONArray: data)
            handler(lists)
        }
    }
    
}
