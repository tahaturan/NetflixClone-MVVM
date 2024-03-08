//
//  HomeViewModelContracts.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 6.03.2024.
//

import Foundation

protocol HomeViewModelContracts: AnyObject {
    var delegate: HomeViewModelDelegate? { get set }
    var service: NetworkServiceProtocol { get set}
    func loadMovie()
    func setLoading(_ isLoading: Bool)
}


enum HomeViewModelOutput {
    case popularMovies([MovieResult])
    case upComingMovies([MovieResult])
    case topRatedMovies([MovieResult])
    case trendingTv([MovieResult])
    case error(Error)
    case setLoading(Bool)
}

protocol HomeViewModelDelegate: AnyObject {
    func handleOutput(_ output: HomeViewModelOutput)
}
