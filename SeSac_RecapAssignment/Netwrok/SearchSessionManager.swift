//
//  SearchSessionManager.swift
//  SeSac_RecapAssignment
//
//  Created by youngjoo on 2/6/24.
//

import Foundation

class SearchSessionManager {
    
    static let shared = SearchSessionManager()
    
    typealias completionHandler<T: Decodable> = (T?, ErrorStatus?) -> Void
    
    private init() {}
    
    let baseURL = "https://openapi.naver.com/v1/search/shop.json"
    
    // 제네릭을 이용해서 Decodable 구조체 가져오기
    // completionHandler 로 내보낼 때 제네릭을 사용한다면, typealias 에도 <T> 를 명시해줘야함
    func callRequest<T: Decodable>(type: T.Type, text: String, sort: String, start: Int, completionHandler: @escaping completionHandler<T>) {
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        //?query=\(query)&display=30&start=\(start)&sort=\(sort)
        
        var component = URLComponents()
        component.scheme = "https"
        
        // host 는 반드시 도메인 주소까지만 작성해야한다.
        component.host = "openapi.naver.com"
        
        // path 는 / 으로 시작하는 경로가 작성되어야 한다.
        component.path = "/v1/search/shop.json"
        
        component.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "display", value: "30"),
            URLQueryItem(name: "start", value: "\(start)"),
            URLQueryItem(name: "sort", value: "\(sort)"),
        ]
        
        guard let componentURL = component.url else {
            print("url 변환 실패")
            return
        }
        
        var url = URLRequest(url: componentURL)
        url.addValue(APIKey.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        url.addValue(APIKey.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("네트워크 통신 실패")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("데이터 안들어왔음")
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("상태코드 안들어옴")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("제대로 된 상태코드가 아니라서 값을 못받아옴")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                do {
                    let data = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(data, nil)
                } catch {
                    print("error")
                    completionHandler(nil, .invalidData)
                }
            }
            
        }.resume()
        
    }
}
