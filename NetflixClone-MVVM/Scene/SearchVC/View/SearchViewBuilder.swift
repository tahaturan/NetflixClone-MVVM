//
//  SearchViewBuilder.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 16.03.2024.
//

import Foundation

final class SearchViewBuilder {
    static func makeSearchViewController() -> SearchViewController {
        let searchVC = SearchViewController()
        let searchViewModel = SearchViewModel(service: NetworkCaller())
        searchVC.searchViewModel = searchViewModel
        return searchVC
    }
}
