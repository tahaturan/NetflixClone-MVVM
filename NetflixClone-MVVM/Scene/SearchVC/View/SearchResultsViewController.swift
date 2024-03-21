//
//  SearchResultsViewController.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 15.03.2024.
//

import UIKit
import SnapKit
protocol SearchResultsViewDelegate: AnyObject {
    func didSelectMovie(_ movieID: Int)
}
class SearchResultsViewController: UIViewController {
    //MARK: - Properties
     var movieList: [MovieResult] = []
    weak var delegate: SearchResultsViewDelegate?
    //MARK: - UIComponents
     lazy var searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.bounds.width / 3 - 10, height: view.bounds.height * 0.2)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    //MARK: - LifeCycl
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
    
    }
   
}
//MARK: - Helper
extension SearchResultsViewController {
    private func setupUI() {
        view.backgroundColor = .viewBackround
        view.addSubview(searchResultCollectionView)
    }
    private func setupLayout() {
        searchResultCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(5)
        }
    }
}
//MARK: - UICollectionView Delegate/DataSource
extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        let movie = movieList[indexPath.row]
        cell.configureCell(searchMovie: movie)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieID = movieList[indexPath.row].id ?? 178
        self.delegate?.didSelectMovie(movieID)
    }
}
