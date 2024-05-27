//
//  RealworldAPI.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/27/24.
//

import Foundation
import Moya

// MARK: - Domain
enum RealworldDomain {
    case articles
    case profiles
    case tags
    case users
    case user
}

extension RealworldDomain {
    var url: String {
        switch self {
        case .articles:
            return "/articles"
        case .profiles:
            return "/profiles"
        case .tags:
            return "/tags"
        case .users:
            return "/users"
        case .user:
            return "/user"

        }
    }
}

protocol RealworldAPI: TargetType {
    var domain: RealworldDomain { get }
    var urlPath: String { get }
    var error: [Int: NetworkError]? { get }
}

extension RealworldAPI {
    var baseURL: URL {
        return URL(string: PrivacyInfoManager.baseURL)!
    }
    
    var path: String {
        return domain.url + urlPath
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
