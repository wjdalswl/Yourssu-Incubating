//
//  ArticlesResonse.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/27/24.
//

import Foundation

// MARK: -아티클 조회 DTO
struct GetArticlesDTO: Codable {
    let articles: [ArticleDTO]
    let articlesCount: Int
}

struct ArticleDTO: Codable {
    let slug: String
    let title: String
    let description: String
    let body: String
    let tagList: [String]
    let createdAt: String
    let updatedAt: String
    let favorited: Bool
    let favoritesCount: Int
    let author: AuthorDTO
}

struct AuthorDTO: Codable {
    let username: String
    let bio: String?
    let image: String
    let following: Bool
}
