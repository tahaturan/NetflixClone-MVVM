//
//  HomeHeaderCollectionViewCell.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 4.03.2024.
//

import UIKit
import SDWebImage
class HomeHeaderCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "HomeHeaderCollectionViewCell"
    private let headerImageView: UIImageView = {
          let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
          imageView.clipsToBounds = true
          imageView.image = .header
        imageView.layer.cornerRadius = 10
          return imageView
      }()
   private let popularImageView: UIImageView = {
        let imageView = UIImageView()
       imageView.image = .popularTag
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.generalTitle.font()
        label.numberOfLines = 0
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(headerImageView)
        contentView.addSubview(popularImageView)
        contentView.addSubview(titleLabel)
       setupLayout()
       addGradient()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        headerImageView.image = nil
        titleLabel.text = nil
    }
    func configureCell(movie: MovieResult) {
        guard let imageURLString = movie.backdropPath else { return }
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(imageURLString)")
        headerImageView.sd_setImage(with: imageURL)
        titleLabel.text = movie.title
        
    }
    private func addGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.viewBackround.withAlphaComponent(0.8).cgColor]
        gradient.frame = bounds
        gradient.locations = [0,1]
        layer.addSublayer(gradient)
    }
    private func setupLayout() {
        headerImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        popularImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.trailing.equalTo(contentView.snp.trailing)
            make.width.equalTo(contentView.frame.width * 0.35)
            make.height.equalTo(contentView.frame.height * 0.11)
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(60)
        }
    }
}
