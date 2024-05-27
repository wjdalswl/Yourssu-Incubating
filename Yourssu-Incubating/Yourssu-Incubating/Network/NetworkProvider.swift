//
//  NetworkProvider.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/27/24.
//

import Foundation
import Moya

final class NetworkProvider<API: RealworldAPI> {
    
    private let provider: MoyaProvider<API>
    
    init(plugins: [PluginType] = []) {
        self.provider = MoyaProvider(plugins: plugins)
    }
    
    func request(api: API, completion: @escaping (Result<Response, MoyaError>) -> Void) {
        let requestString = "\(api.urlPath)"
        
        provider.request(api) { result in
            switch result {
            case let .success(response):
                print("SUCCESS: \(requestString) (\(response.statusCode))")
                completion(.success(response))
                
            case let .failure(error):
                print("ERROR: \(requestString)")
                completion(.failure(error))
            }
        }
    }
}
