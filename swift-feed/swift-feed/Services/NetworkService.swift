//
//  NetworkService.swift
//  swift-feed
//
//  Created by Abi  Radzhabova on 24/10/21.
//

import Foundation
import Alamofire

protocol Networking {
    func request(path: String, params: [String: String], complition: @escaping (FeedResponseWrapped?, Error?) -> Void)
}

class NetworkService: Networking {
    
    private let authService: AuthService
    
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
    
    func request(path: String, params: [String : String], complition: @escaping (FeedResponseWrapped?, Error?) -> Void) {
        guard let token = authService.token else { return }
                
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        
        let url = self.url(from: path, params: allParams)
        
        print("URL", url)
        let request = AF.request(url)
//        let request = URLRequest(url: url)
        let task = createDataTask(from: request, complition: complition)
        
        task.resume()
    }
    
    private func createDataTask(from request: DataRequest, complition: @escaping (FeedResponseWrapped?, Error?) -> Void) -> DataRequest {
        
        request.validate()
        
        return request.responseDecodable { (response: DataResponse<FeedResponseWrapped, AFError>) in
            DispatchQueue.main.async {
                print("ERROR", response.error)
                print("RESPONSE", response.value?.response.items)
                complition(response.value, response.error)
            }
        }
        
//        return request.responseDecodable(of: FeedResponseWrapped.self) { [weak self] response, error in
//            DispatchQueue.main.async {
//                print("RESPONSE", response.value?.response.items)
//                complition(response.value?.response, <#Error?#>)
//            }
//        }
//        return URLSession.shared.dataTask(with: request) { data, response, error in
//            DispatchQueue.main.async {
//                complition(data, error)
//            }
//        }
    }
}
