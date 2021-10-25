//
//  NetworkDataFetcher.swift
//  swift-feed
//
//  Created by Abi  Radzhabova on 25/10/21.
//

import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post,photo"]
        networking.request(path: API.newsFeed, params: params) { data, error in
            if let error = error {
                print("ERROR recievd", error.localizedDescription)
                response(nil)
            }
            
//            let decoded = decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(data?.response)
        }
    }
    
//    private func decodeJSON<T: Decodable>(type: T.Type, from: FeedResponseWrapped?) -> T? {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//        guard let data = from else { return nil }
//
//        do {
//            let response = try decoder.decode(type.self, from: data)
//            print("RESPONSE", response)
//            return response
//        } catch let error {
//            print("SOME ERROR", error.localizedDescription)
//            return nil
//        }
//    }
}
