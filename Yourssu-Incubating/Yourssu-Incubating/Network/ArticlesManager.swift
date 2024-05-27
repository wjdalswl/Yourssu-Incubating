//
//  ArticlesManager.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/27/24.
//

import Foundation
import Moya

final class ArticlesManager {
    typealias API = ArticlesAPI
    
    static let shared = ArticlesManager()
    let provider = NetworkProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    private init() {}
    
    // MARK: - 아티클 조회 API
    func getArticles(
        tag: String? = nil,
        author: String? = nil,
        favorited: String? = nil,
        offset: Int? = nil,
        limit: Int? = nil,
        completion: @escaping (Result<GetArticlesDTO, MoyaError>) -> Void
    ) {
        provider.request(api: .getArticles(
            tag: tag,
            author: author,
            favorited: favorited,
            offset: offset,
            limit: limit
        )) { result in
            switch result {
            case .success(let response):
                do {
                    let decodedResponse = try JSONDecoder().decode(GetArticlesDTO.self, from: response.data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(MoyaError.underlying(error, response)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
