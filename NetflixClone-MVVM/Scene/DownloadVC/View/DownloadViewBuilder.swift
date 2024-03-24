//
//  DownloadViewBuilder.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 24.03.2024.
//

import Foundation

final class DownloadViewBuilder {
    static func makeDowloadVieController() -> DownloadViewController {
        let downloadVC = DownloadViewController()
        downloadVC.downloadViewModel = DownloadViewModel()
        return downloadVC
    }
}
