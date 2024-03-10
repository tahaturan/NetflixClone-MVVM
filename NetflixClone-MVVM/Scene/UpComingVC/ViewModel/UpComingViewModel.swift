//
//  UpComingViewModel.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 10.03.2024.
//

import Foundation

final class UpComingViewModel: UpComingViewModelContracts {
    weak var delagate: UpComingViewModelDelegate?
    
    var service: NetworkServiceProtocol
    
    init(service: NetworkServiceProtocol) {
        self.service = service
    }
    
    func getUpcomingMovies() {
        setLoading(true)
        service.fetchData(.upComing) { [weak self] (result: Result<Movie, NetworkError>) in
            self?.setLoading(false)
            switch result {
            case .success(let movie):
                self?.delagate?.handleOutput(.upComingMovies(movie.results ?? []))
            case .failure(let error):
                self?.delagate?.handleOutput(.error(error))
            }
        }
    }
    
    func setLoading(_ isLoading: Bool) {
        self.delagate?.handleOutput(.setLoading(isLoading))
    }
    
    
}
