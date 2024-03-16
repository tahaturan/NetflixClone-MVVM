//
//  SearchViewModelContracts.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 16.03.2024.
//

import Foundation


protocol SearchViewModelContracts: AnyObject {
    var delagate: SearchViewModelDelegate? { get set }
    var service: NetworkServiceProtocol { get set}
    func getSearchMovie(width name: String)
    func setLoading(_ isLoading: Bool)
}

enum SearchViewModelOutput {
    case searchMovieResult([MovieResult])
    case error(Error)
    case setLoading(Bool)
}


protocol SearchViewModelDelegate {
    func handleOutput(_ output: SearchViewModelOutput)
}
