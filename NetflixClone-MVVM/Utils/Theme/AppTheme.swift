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
}
extension AppFont {
    func font() -> UIFont {
        switch self {
        case .generalTitle:
            return UIFont.systemFont(ofSize: 32, weight: .bold)
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
