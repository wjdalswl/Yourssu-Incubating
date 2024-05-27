//
//  ArticleView.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/28/24.
//

import UIKit
import Then
import YDS
import SnapKit
import RxSwift
import RxCocoa

final class ArticleView: UIView {
    // MARK: - Properties
    var isFollowing = false {
        didSet {
            updateFavoriteButton()
        }
    }
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let titleLabel = YDSLabel().then {
        $0.textColor = YDSColor.textPrimary
        $0.numberOfLines = 0
        $0.style = .subtitle1
    }
    let tagsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 8
    }
    let bodyLabel = YDSLabel().then {
        $0.textColor = YDSColor.textSecondary
        $0.numberOfLines = 0
    }
    let authorImageView = YDSProfileImageView().then {
        $0.size = .medium
    }
    let authorNameLabel = YDSLabel().then {
        $0.textColor = YDSColor.bgNormalDark
        $0.numberOfLines = 1
        $0.alignment = .center
    }
    let favoritButton = YDSPlainButton().then {
        $0.size = .large
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    private func setLayout() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [titleLabel, tagsStackView, bodyLabel, authorImageView, authorNameLabel, favoritButton].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        tagsStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
        bodyLabel.snp.makeConstraints {
            $0.top.equalTo(tagsStackView.snp.bottom).offset(16)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        authorImageView.snp.makeConstraints {
            $0.top.equalTo(bodyLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-32)
        }
        authorNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(authorImageView.snp.centerY)
            $0.leading.equalTo(authorImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(favoritButton.snp.leading).offset(-20)
        }
        favoritButton.snp.makeConstraints {
            $0.centerY.equalTo(authorImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(48)
        }
    }
    
    // MARK: - Method
    func bindTags(tags: [String]) {
        tagsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        tags.forEach { tag in
            let label = YDSBadge().then {
                $0.text = tag
                $0.icon = YDSIcon.clipLine
                $0.color = YDSItemColor.emerald
            }
            tagsStackView.addArrangedSubview(label)
        }
    }
    
    private func updateFavoriteButton() {
        let icon = isFollowing ? YDSIcon.starFilled : YDSIcon.starLine
        favoritButton.leftIcon = icon
    }
}
