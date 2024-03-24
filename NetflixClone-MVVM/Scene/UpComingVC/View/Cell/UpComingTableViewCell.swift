//
//  UpComingTableViewCell.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 10.03.2024.
//

import UIKit
import SnapKit

class UpComingTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier: String = "UpComingTableViewCell"
    //MARK: - UICompanents
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = AppFont.upComingTitle.font()
        label.textColor = .white
        return label
    }()
    private let playButton: UIButton = {
        let button = UIButton()
        button.setImage(AppIcon.upComing.image().withConfiguration(UIImage.SymbolConfiguration(pointSize: UIScreen.screenWidth * 0.1)), for: .normal)
        button.tintColor = .white
        return button
    }()
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)
     
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview()
            make.width.equalTo(contentView.frame.width * 0.4)
            make.bottom.equalToSuperview().inset(10)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.centerY.equalTo(posterImageView.snp.centerY)
            make.width.equalTo(contentView.bounds.width * 0.5)
        }
        playButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).inset(20)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    
    func configureCell(_ movie: MovieResult) {
        guard let movieImageString = movie.posterPath else { return  }
        guard let movieTitle = movie.title else { return }
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(movieImageString)")
        posterImageView.sd_setImage(with: imageURL)
        titleLabel.text = movieTitle
    }
    func configureCell(realmMovie: RealmMovieObject) {
        guard let imageData = realmMovie.movieImage else { return  }
        titleLabel.text = realmMovie.title
        posterImageView.image = UIImage(data: imageData)
    }
}
