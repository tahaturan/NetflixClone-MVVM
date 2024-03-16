//
//  SearchViewModel.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 16.03.2024.
//

import Foundation

final class SearchViewModel: SearchViewModelContracts {
    var delagate: SearchViewModelDelegate?
    
    var service: NetworkServiceProtocol
    init(service: NetworkServiceProtocol) {
        self.service = service
    }
    func getSearchMovie(width name: String) {
        setLoading(true)
        service.fetchData(.searchMovie(name: name)) {[weak self] (result: Result<Movie, NetworkError>) in
            self?.setLoading(false)
            switch result {
            case .success(let movie):
                self?.delagate?.handleOutput(.searchMovieResult(movie.results ?? []))
            case .failure(let error):
                self?.delagate?.handleOutput(.error(error))
            }
        }
    }
    
    func setLoading(_ isLoading: Bool) {
        self.delagate?.handleOutput(.setLoading(isLoading))
    }
    
    
}
