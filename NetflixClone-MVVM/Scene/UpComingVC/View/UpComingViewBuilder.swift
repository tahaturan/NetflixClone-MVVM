//
//  UpComingViewBuilder.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 10.03.2024.
//

import Foundation

final class UpComingViewBuilder {
    static func makeUpComingViewController() -> UpComingViewController {
        let upComingVC = UpComingViewController()
        let upComingViewModel = UpComingViewModel(service: NetworkCaller())
        upComingVC.upComingViewModel = upComingViewModel
        return upComingVC
    }
}
