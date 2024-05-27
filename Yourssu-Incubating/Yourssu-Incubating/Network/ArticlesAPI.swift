//
//  ArticlesAPI.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/27/24.
//

import Foundation
import Moya

enum ArticlesAPI {
    case getArticles(tag: String?, author: String?, favorited: String?, offset: Int?, limit: Int?)
}

extension ArticlesAPI: RealworldAPI {
    var domain: RealworldDomain {
        return .articles
    }
    
    var urlPath: String {
        switch self {
        case .getArticles:
            return ""
        }
    }
    var error: [Int : NetworkError]? {
        .none
    }
    
    var headers: [String : String]? {
        switch self {
        case .getArticles:
            return ["Content-Type": "application/json"]
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getArticles:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getArticles(
            tag: let tag,
            author: let author,
            favorited: let favorited,
            offset: let offset,
            limit: let limit):
            var parameters: [String: Any] = [:]
            
            if let tag = tag {
                parameters["tag"] = tag
            }
            if let author = author {
                parameters["author"] = author
            }
            if let favorited = favorited {
                parameters["favorited"] = favorited
            }
            if let offset = offset {
                parameters["offset"] = offset
            }
            if let limit = limit {
                parameters["limit"] = limit
            }
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
