//
//  CategoryTableViewCell.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 12.03.2024.
//

import UIKit
import SnapKit

class CategoryTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier: String = "CategoryTableViewCell"
    //MARK: - UIComponents
    let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.movieTableView.font()
        return label
    }()
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.backgroundColor = .clear
        contentView.addSubview(categoryImageView)
        contentView.addSubview(titleLabel)
        
        categoryImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(contentView.bounds.width * 0.3)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(categoryImageView.snp.trailing).offset(15)
            make.centerY.equalTo(categoryImageView.snp.centerY)
            make.width.equalTo(contentView.bounds.width * 0.5)
        }
    }
    func configureCell(_ category: MovieCategoryModel) {
        categoryImageView.image = category.categoryImage
        titleLabel.text = category.categoryName
    }
}
