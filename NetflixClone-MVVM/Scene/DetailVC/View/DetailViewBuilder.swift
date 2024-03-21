//
//  DetailViewBuilder.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 20.03.2024.
//

import Foundation

final class DetailViewBuilder {
    static func makeDetailViewController(movieID: Int) -> DetailViewController {
        let detailVC = DetailViewController()
        detailVC.detailViewModel = DetailViewModel(service: NetworkCaller(), movieId: movieID)
        return detailVC
    }
}
