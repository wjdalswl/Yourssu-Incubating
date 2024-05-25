//
//  MemoTableViewCell.swift
//  Yourssu-Incubating
//
//  Created by 정민지 on 5/12/24.
//

import UIKit
import SnapKit
import Then

final class MemoTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "MemoTableViewCell"
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 17)
    }
    private let contentLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
        $0.numberOfLines = 1
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetLayout
    private func setLayout() {
        selectionStyle = .none
        
        [titleLabel, contentLabel].forEach {
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview()
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15)
        }
    }
    
    //MARK: - Configure
    func configure(with memo: MemoModel) {
        titleLabel.text = memo.title
        contentLabel.text = memo.content
    }
}
