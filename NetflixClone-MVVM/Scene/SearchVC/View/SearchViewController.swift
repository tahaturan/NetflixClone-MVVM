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
    var searchViewModel: SearchViewModel?
    //MARK: - UIComponents
    private lazy var backroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .searchbackgroundIMG
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private lazy var searchController: UISearchController = {
        let searchResultController = SearchResultsViewController()
        searchResultController.delegate = self
        let search = UISearchController(searchResultsController: searchResultController)
        search.searchBar.placeholder = "Search"
        search.obscuresBackgroundDuringPresentation = true
        search.searchBar.scopeButtonTitles = ["Movie", "TV Show", "Popular"]
        search.searchBar.backgroundColor = .clear
        search.searchBar.setScopeBarButtonTitleTextAttributes([.foregroundColor: UIColor.tabbarSelected], for: .normal)
        search.searchBar.tintColor = .white
        
        search.searchBar.delegate = self
        search.searchResultsUpdater = self
        return search
    }()
    lazy var searchedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .viewBackround
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SearchedCollectionViewCell.self, forCellWithReuseIdentifier: SearchedCollectionViewCell.idendifier)
        collectionView.register(SearchedSectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchedSectionHeaderCollectionReusableView.identifier)
        return collectionView
    }()
    private var indicator: CustomActivityIndicator = CustomActivityIndicator()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        configureNavAndTabbar()
        searchViewModel?.delagate = self
    }
}
//MARK: - Helper
extension SearchViewController {
    private func setupUI() {
        view.backgroundColor = .viewBackround
        title = "Search"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.searchController = searchController
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
        searchedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    private func configureNavAndTabbar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.clear
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.clear
        tabBarController?.tabBar.standardAppearance = tabBarAppearance
        tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
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
//MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty,searchText.count >= 3 else { return }
        
        self.searchViewModel?.getSearchMovie(width: searchText)
    }
}
//MARK: - SearchViewModelDelegate
extension SearchViewController: SearchViewModelDelegate {
    func handleOutput(_ output: SearchViewModelOutput) {
        switch output {
        case .searchMovieResult(let array):
            DispatchQueue.main.async {
                guard let searchResultContoller = self.searchController.searchResultsController as? SearchResultsViewController else {return}
                searchResultContoller.movieList = array
                searchResultContoller.searchResultCollectionView.reloadData()
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
        searchController.isActive = true
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
//MARK: - SearchResultsViewDelegate
extension SearchViewController: SearchResultsViewDelegate {
    func didSelectMovie(_ movieID: Int) {
        let detailVC = DetailViewBuilder.makeDetailViewController(movieID: movieID)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
