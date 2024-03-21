//
//  DetailViewController.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 17.03.2024.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: - Properties
    var detailViewModel: DetailViewModel?
    //MARK: - UIComponents
    private lazy var backroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .homebackgroundIMG
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = AppFont.detailTitle.font()
        return label
    }()
    private lazy var yearLabel: UILabel = createLabel()
    private lazy var genreLabel: UILabel = createLabel()
    private lazy var runTimeLabel: UILabel = createLabel()
    private let imdbImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = .imdb
        image.clipsToBounds = true
        return image
    }()
    private lazy var imdbLabel: UILabel = createLabel()
    private let playButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .tabbarSelected
        configuration.baseForegroundColor = .white
        configuration.image = AppIcon.play.image()
        configuration.imagePadding = 10
        configuration.attributedTitle = AttributedString(NSAttributedString(string: "Play", attributes: [.font: AppFont.movieTableView.font()]))
        button.configuration = configuration
        return button
    }()
    private let toolbarView: CustomToolbar = CustomToolbar()
    private let summariesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.detailTitle.font()
        label.text = "Summaries"
        label.textColor = .white
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private var indicator: CustomActivityIndicator = CustomActivityIndicator()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        detailViewModel?.delegate = self
        detailViewModel?.getMovieDetail()
    }
}
//MARK: - Helper
extension DetailViewController {
    private func setupUI() {
        view.backgroundColor = .viewBackround
        view.addSubview(backroundImageView)
        view.sendSubviewToBack(backroundImageView)
        view.addSubview(movieImageView)
        view.addSubview(titleLabel)
        view.addSubview(yearLabel)
        view.addSubview(genreLabel)
        view.addSubview(runTimeLabel)
        view.addSubview(imdbImageView)
        view.addSubview(imdbLabel)
        view.addSubview(playButton)
        view.addSubview(toolbarView)
        view.addSubview(summariesTitleLabel)
        view.addSubview(descriptionLabel)
        
    }
    private func setupLayout() {
        backroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        movieImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().inset(10)
            make.width.equalTo(view.bounds.width * 0.45)
            make.height.equalTo(view.bounds.width * 0.63)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView)
            make.leading.equalTo(movieImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-10)
        }
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalTo(titleLabel)
        }
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(yearLabel)
            make.leading.equalTo(yearLabel.snp.trailing).offset(5)
            make.trailing.equalTo(titleLabel)
        }
        runTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottom)
            make.leading.equalTo(titleLabel)
        }
        imdbImageView.snp.makeConstraints { make in
            make.top.equalTo(runTimeLabel.snp.bottom).offset(30)
            make.leading.equalTo(titleLabel)
            make.width.equalTo(view.bounds.width * 0.1)
            make.height.equalTo(view.bounds.width * 0.15)
        }
        imdbLabel.snp.makeConstraints { make in
            make.leading.equalTo(imdbImageView.snp.trailing).offset(5)
            make.centerY.equalTo(imdbImageView.snp.centerY)
        }
        playButton.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(view.bounds.height * 0.05)
        }
        toolbarView.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        summariesTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(toolbarView.snp.bottom).offset(10)
            make.leading.equalTo(movieImageView)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(summariesTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
    private func stringToDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy"
            let yearString = dateFormatter.string(from: date)
            return yearString
        } else {
            return ""
        }
    }
    private func createGenreText(genreList: [Genre]) -> String {
        var genreString: String = ""
        for i in genreList {
           genreString += "\(i.name ?? ""),"
        }
        return genreString
    }
}
//MARK: - DetailViewModelDelegate
extension DetailViewController: DetailViewModelDelegate {
    func handleOutput(_ output: DetailViewModelOutput) {
        switch output {
        case .movie(let movieDetail):
            DispatchQueue.main.async {
                if let imageURLString = movieDetail.posterPath  {
                    let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(imageURLString)")
                    self.movieImageView.sd_setImage(with: imageURL)
                } else {
                    self.movieImageView.image = .header
                }
                self.titleLabel.text = movieDetail.title
                self.yearLabel.text = self.stringToDate(dateString: movieDetail.releaseDate!)
                self.genreLabel.text = self.createGenreText(genreList: movieDetail.genres ?? [])
                self.runTimeLabel.text = "\(movieDetail.runtime! / 60)h \(movieDetail.runtime! % 60)min"
                self.imdbLabel.text = "\(movieDetail.voteAverage ?? 0)"
                self.descriptionLabel.text = movieDetail.overview ?? ""
            }
        case .error(let error):
            print(error)
        case .setLoading(let isLoading):
            DispatchQueue.main.async {
                isLoading ? self.indicator.show(on: self) : self.indicator.hide()
            }
        }
    }
    
    
}
//MARK: - FactoryMethods
extension DetailViewController {
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .gray
        label.font = AppFont.detailLabel.font()
        label.textAlignment = .left
        return label
    }
}
