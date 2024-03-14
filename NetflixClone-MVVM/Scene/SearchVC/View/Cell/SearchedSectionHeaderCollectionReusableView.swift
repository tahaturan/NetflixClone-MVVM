//
//  SearchedSectionHeaderCollectionReusableView.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 14.03.2024.
//

import UIKit

class SearchedSectionHeaderCollectionReusableView: UICollectionReusableView {
    //MARK: - Properties
    static let identifier: String = "SearchedSectionHeaderCollectionReusableView"
    //MARK: - UIComponenst
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.generalTitle.font()
        return label
    }()
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
