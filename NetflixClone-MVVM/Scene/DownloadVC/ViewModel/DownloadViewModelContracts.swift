//
//  DownloadViewModelContracts.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 24.03.2024.
//

import Foundation
import RealmSwift

protocol DownloadViewModelContracts: AnyObject {
    var delegate: DownloadViewModelDelegate? { get set }
    var realmService: RealmService { get set }
    func getMovieToRealm()
    func deleteMovieToRealm(_ movie: RealmMovieObject)
}

enum DownloadViewModelOutput {
    case movieList([RealmMovieObject])
}

protocol DownloadViewModelDelegate: AnyObject {
    func handleOutput(_ output: DownloadViewModelOutput)
}
