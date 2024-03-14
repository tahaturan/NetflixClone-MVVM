//
//  SearchViewController.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 12.02.2024.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    //MARK: - Properties
    private var feturedList: [String] = ["Anime", "IT", "Halloween", "Comedy", "Peaky Blinders", "Mery Chirstmas"]
    private var searchedList: [String] = ["The Walking Dead", "Startup", "Ben 10", "The Witches","Damsel"]
    //MARK: - UIComponents
    private lazy var backroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .searchbackgroundIMG
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let searchController: UISearchController = {
        let search = UISearchController()
        search.searchBar.placeholder = "Search"
        search.obscuresBackgroundDuringPresentation = true
        search.searchBar.scopeButtonTitles = ["Movie", "TV Show", "Popular"]
        search.searchBar.scopeBarBackgroundImage = .searchbackgroundIMG
        search.searchBar.setScopeBarButtonTitleTextAttributes([.foregroundColor: UIColor.tabbarSelected], for: .normal)
        search.searchBar.tintColor = .white
        return search
    }()
    lazy var searchedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SearchedCollectionViewCell.self, forCellWithReuseIdentifier: SearchedCollectionViewCell.idendifier)
        collectionView.register(SearchedSectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchedSectionHeaderCollectionReusableView.identifier)
        return collectionView
    }()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
}
//MARK: - Helper
extension SearchViewController {
    private func setupUI() {
        view.backgroundColor = .viewBackround
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.textColor = .white
        definesPresentationContext = true
        view.addSubview(backroundImageView)
        view.sendSubviewToBack(backroundImageView)
        view.addSubview(searchedCollectionView)
    
    }
    private func setupLayout() {
        backroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsScopeBar = true
        searchBar.sizeToFit()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsScopeBar = false
        searchBar.sizeToFit()
    }
}
//MARK: - UICollectionView DataSource/Delegate
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? feturedList.count : searchedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchedCollectionViewCell.idendifier, for: indexPath) as? SearchedCollectionViewCell else { return UICollectionViewCell() }
        let title = indexPath.section == 0 ? feturedList[indexPath.item] : searchedList[indexPath.item]
        cell.configureCell(with: title)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return  }
        let text = indexPath.section == 0 ? feturedList[indexPath.item] : searchedList[indexPath.item]
        searchController.searchBar.text = text
        
        UIView.animate(withDuration: 0.1) {
            cell.backgroundColor = .tabbarSelected.withAlphaComponent(0.5)
        } completion: { completion in
            UIView.animate(withDuration: 0.1) {
                cell.backgroundColor = .tabbarSelected.withAlphaComponent(0.2)
            }
        }

        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
          switch kind {
          case UICollectionView.elementKindSectionHeader:
              let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchedSectionHeaderCollectionReusableView.identifier, for: indexPath) as! SearchedSectionHeaderCollectionReusableView
              headerView.titleLabel.text = indexPath.section == 0 ? "Featured" : "Searched"
              return headerView
          default:
              assert(false, "Unexpected element kind")
          }
      }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        
        let cellWidth = (width - view.bounds.height * 0.03 * 4) / 3
        return CGSize(width: cellWidth, height: view.bounds.height * 0.055)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return view.bounds.height * 0.03
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return view.bounds.height * 0.03
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: view.bounds.height * 0.04)
    }
}
