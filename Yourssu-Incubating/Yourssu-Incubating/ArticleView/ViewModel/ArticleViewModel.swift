//
//  ArticleViewModel.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/27/24.
//

import RxSwift
import Foundation

struct ArticleResult {
    let title: String
    let tagList: [String]
    let body: String
    let authorImage: String
    let authorName: String
    let following: Bool
}

class ArticleViewModel {
    private let disposeBag = DisposeBag()
    private let articlesManager = ArticlesManager.shared
    
    // MARK: - Input
    struct Input {
        let getArticlesTrigger: Observable<Void>
    }
    
    // MARK: - Output
    struct Output {
        let article: Observable<ArticleResult?>
    }
    
    // MARK: - Transformation
    func transform(_ input: Input) -> Output {
        let article = input.getArticlesTrigger
            .flatMapLatest { [weak self] _ -> Observable<ArticleResult?> in
                guard let self = self else { return Observable.just(nil) }
                return self.getArticles(tag: nil, author: nil, favorited: nil, offset: nil, limit: 1)
            }
            .observe(on: MainScheduler.instance)
        
        return Output(article: article)
    }
    
    // MARK: - API
    private func getArticles(tag: String?, author: String?, favorited: String?, offset: Int?, limit: Int?) -> Observable<ArticleResult?> {
        return Observable.create { observer in
            self.articlesManager.getArticles(
                tag: tag,
                author: author,
                favorited: favorited,
                offset: offset,
                limit: limit
            ) { result in
                switch result {
                case .success(let response):
                    if let articleDTO = response.articles.first {
                        let article = ArticleResult(
                            title: articleDTO.title,
                            tagList: articleDTO.tagList,
                            body: articleDTO.body,
                            authorImage: articleDTO.author.image,
                            authorName: articleDTO.author.username,
                            following: articleDTO.author.following
                        )
                        observer.onNext(article)
                    } else {
                        observer.onNext(nil)
                    }
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
