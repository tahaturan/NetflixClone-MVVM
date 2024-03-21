//
//  DetailViewModelContracts.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 20.03.2024.
//

import Foundation


protocol DetailViewModelContracts {
    var delegate: DetailViewModelDelegate? { get set }
    var service: NetworkServiceProtocol { get set }
    var movieId: Int { get set }
    func getMovieDetail()
    func setLoading(_ isLoading: Bool)
}

enum DetailViewModelOutput {
    case movie(MovieDetail)
    case error(Error)
    case setLoading(Bool)
}

protocol DetailViewModelDelegate {
    func handleOutput(_ output: DetailViewModelOutput)
}
