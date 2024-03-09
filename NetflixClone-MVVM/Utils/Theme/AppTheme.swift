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
}
extension AppFont {
    func font() -> UIFont {
        switch self {
        case .generalTitle:
            return UIFont.systemFont(ofSize: 32, weight: .bold)
        case .movieTableView:
            return UIFont.systemFont(ofSize: 18, weight: .semibold)
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
