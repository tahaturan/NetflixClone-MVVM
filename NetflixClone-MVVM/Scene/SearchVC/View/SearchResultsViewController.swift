//
//  SearchResultsViewController.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 15.03.2024.
//

import UIKit
import SnapKit

class SearchResultsViewController: UIViewController {
    //MARK: - Properties
    private var movieList: [MovieResult] = []
    //MARK: - UIComponents
    private lazy var searchResultCollectionView: UICollectionView = {
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
//MARK: -
extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .red
        return cell
    }
}
