//
//  DownloadViewModel.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 24.03.2024.
//

import Foundation

final class DownloadViewModel: DownloadViewModelContracts {

    weak var delegate: DownloadViewModelDelegate?
    
    var realmService: RealmService = RealmService()
    
    func getMovieToRealm() {
        let movieList = realmService.getMoviesRealm()
        self.delegate?.handleOutput(.movieList(movieList))
    }
    
    func deleteMovieToRealm(_ movie: RealmMovieObject) {
        realmService.deleteMovieRealm(movie: movie)
    }
    
}
