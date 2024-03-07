//
//  HomeHeaderFooterView.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 7.03.2024.
//

import UIKit
import SnapKit

class HomeHeaderFooterView: UITableViewHeaderFooterView {

    static let identifier: String = "HomeHeaderFooterView"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.setTitleColor(.tabbarSelected, for: .normal)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContent() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(seeAllButton)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(10)
        }
        seeAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
        }
    }
}
