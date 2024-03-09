//
//  MovieCollectionViewTableViewCell.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 26.02.2024.
//

import UIKit

class MovieCollectionViewTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier: String = "MovieCollectionViewTableViewCell"
    private var movieList: [MovieResult] = []
    //MARK: - UICompanents
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.screenWidth * 0.35, height: UIScreen.screenWidth * 0.52)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ movieList: [MovieResult]) {
        self.movieList = movieList
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionView Delegate/DataSource
extension MovieCollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = movieList[indexPath.row]
        cell.configureCell(movie)
        return cell
    }
}
