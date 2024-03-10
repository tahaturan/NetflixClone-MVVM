//
//  UpComingViewModelContracts.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 10.03.2024.
//

import Foundation

protocol UpComingViewModelContracts: AnyObject {
    var delagate: UpComingViewModelDelegate? { get set }
    var service: NetworkServiceProtocol { get set }
    func getUpcomingMovies()
    func setLoading(_ isLoading: Bool)
}

enum UpComingViewModelOutput {
    case upComingMovies([MovieResult])
    case error(Error)
    case setLoading(Bool)
}

protocol UpComingViewModelDelegate: AnyObject {
    func handleOutput(_ output: UpComingViewModelOutput)
}
