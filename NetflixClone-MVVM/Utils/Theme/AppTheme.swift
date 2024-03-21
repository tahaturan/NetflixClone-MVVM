//
//  AppTheme.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 4.03.2024.
//

import UIKit

//MARK: AppFont
enum AppFont {
case generalTitle
    case movieTableView
    case upComingTitle
    case searhedTitle
    case detailLabel
    case detailTitle
}
extension AppFont {
    func font() -> UIFont {
        switch self {
        case .generalTitle:
            return UIFont.systemFont(ofSize: 32, weight: .bold)
        case .movieTableView:
            return UIFont.systemFont(ofSize: 18, weight: .bold)
        case .upComingTitle:
            return UIFont.systemFont(ofSize: 16, weight: .light)
        case .searhedTitle:
            return UIFont.systemFont(ofSize: 14, weight: .semibold)
        case .detailLabel:
            return UIFont.systemFont(ofSize: 18)
        case .detailTitle:
            return UIFont.systemFont(ofSize: 24, weight: .semibold)
        }
        
    }
}
//MARK: AppSize
enum AppSize {
    case searchButton
}
extension AppSize {
    func size() -> CGSize {
        switch self {
        case .searchButton:
            return CGSize(width: 40, height: 40)
        }
    }
}
