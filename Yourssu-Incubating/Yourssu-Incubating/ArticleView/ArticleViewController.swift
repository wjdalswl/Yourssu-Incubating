//
//  ArticleViewController.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/27/24.
//

import UIKit
import RxSwift
import RxCocoa

final class ArticleViewController: UIViewController {
    // MARK: - Properties
    private let viewModel = ArticleViewModel()
    private let disposeBag = DisposeBag()
    
    private let articleView = ArticleView()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setLayout()
        bindViewModel()
        setupButtonAction()
    }
    
    //MARK: - SetLayout
    private func setLayout() {
        self.view.addSubview(articleView)
        
        articleView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - BindViewModel
    private func bindViewModel() {
        let trigger = self.rx.methodInvoked(#selector(viewDidAppear(_:))).map { _ in }.asObservable()
        
        let input = ArticleViewModel.Input(getArticlesTrigger: trigger)
        
        let output = viewModel.transform(input)
        
        output.article
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (article: ArticleResult) in
                guard let self = self else { return }
                self.articleView.titleLabel.text = article.title
                self.articleView.bodyLabel.text = article.body
                self.articleView.authorNameLabel.text = article.authorName
                self.articleView.isFollowing = article.following
                if let url = URL(string: article.authorImage) {
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url),
                           let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.articleView.authorImageView.image = image
                            }
                        }
                    }
                }
                self.articleView.bindTags(tags: article.tagList)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupButtonAction() {
        articleView.favoritButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.articleView.isFollowing.toggle()
            })
            .disposed(by: disposeBag)
    }
}
