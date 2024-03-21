//
//  AppIcon.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 12.02.2024.
//

import UIKit

enum AppIcon {
    case home
    case discover
    case upComing
    case download
    case search
    case arrowRight
    case play
    case share
    case plus
    case heart
    func image() -> UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house.fill")!
        case .discover:
            return UIImage(systemName: "square.grid.2x2.fill")!
        case .upComing:
            return UIImage(systemName: "play.circle.fill")!
        case .download:
            return UIImage(systemName: "arrow.down.to.line")!
        case .search:
            return UIImage(systemName: "magnifyingglass")!
        case .arrowRight:
            return UIImage(systemName: "arrow.right")!
        case .play:
            return UIImage(systemName: "play.fill")!
        case .share:
            return UIImage(systemName: "arrowshape.turn.up.right.fill")!
        case .plus:
           return UIImage(systemName: "plus")!
        case .heart:
            return UIImage(systemName: "heart")!
        }
    }
}
