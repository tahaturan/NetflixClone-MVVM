//
//  MovieCollectionViewCell.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 8.03.2024.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier: String = "MovieCollectionViewCell"
    //MARK: - UICompanents
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.movieTableView.font()
        label.numberOfLines = 1
        return label
    }()
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
    private func setupLayout() {
        posterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.frame.height * 0.65)
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom).offset(-13)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func configureCell(_ movie: MovieResult) {
        
        //Movie ve Tv model doysalarindan farkli oldugundan biri title seklinde digeri ise name seklinde oldugundan iflet kullanildi
        if let imageURLString = movie.posterPath  {
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(imageURLString)")
            posterImageView.sd_setImage(with: imageURL)
        } else {
            posterImageView.image = .header
        }
        if let movieTitle = movie.title {
            titleLabel.text = movieTitle
        } else {
            titleLabel.text = movie.name
        }
    }
}
