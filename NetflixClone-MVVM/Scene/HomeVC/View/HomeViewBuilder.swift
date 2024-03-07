//
//  HomeViewBuilder.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 7.03.2024.
//

import Foundation

final class HomeViewBuilder {
    static func makeHomeViewController() -> HomeViewController {
        let homeVC = HomeViewController()
        let homeViewModel = HomeViewModel(service: NetworkCaller())
        homeVC.homeViewModel = homeViewModel
        return homeVC
    }
}
