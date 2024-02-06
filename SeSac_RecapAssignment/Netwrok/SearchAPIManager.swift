//
//  SearchAPIManager.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 1/23/24.
//

import UIKit
import Alamofire

class SearchAPIManager {
    
    static let shared = SearchAPIManager()
    
    private init() {}
    
    let baseURL = "https://openapi.naver.com/v1/search/shop.json"
    
    let headers: HTTPHeaders = [
        "X-Naver-Client-Id": APIKey.clientID,
        "X-Naver-Client-Secret": APIKey.clientSecret
    ]
    
    func callRequest(text: String, sort: String, start: Int, completionHandler: @escaping (Search) -> Void) {
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = baseURL + "?query=\(query)&display=30&start=\(start)&sort=\(sort)"
        
        AF.request(url, headers: headers).responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(var data):
                for i in 0..<data.items.count {
                    data.items[i].title = data.items[i].title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                }
                completionHandler(data)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
