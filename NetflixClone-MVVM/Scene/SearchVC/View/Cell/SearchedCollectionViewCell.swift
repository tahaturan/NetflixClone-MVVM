//
//  SearchedCollectionViewCell.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 14.03.2024.
//

import UIKit

class SearchedCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let idendifier: String = "SearchedCollectionViewCell"
    //MARK: - UIComponents
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = AppFont.searhedTitle.font()
        return label
    }()
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Cell
    private func setupCell() {
        contentView.addSubview(titleLabel)
        backgroundColor = .tabbarSelected.withAlphaComponent(0.2)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    func configureCell(with title: String) {
        titleLabel.text = title
    }
}
