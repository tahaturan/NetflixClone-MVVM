//
//  HomeViewModel.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 12.02.2024.
//

import Foundation

final class HomeViewModel: HomeViewModelContracts {
   weak var delegate: HomeViewModelDelegate?
    
    var service: NetworkServiceProtocol
    
    init(service: NetworkServiceProtocol) {
        self.service = service
    }
    
    func loadMovie() {
        setLoading(true)
        service.fetchData(.popular) {[weak self] (result: Result<Movie,NetworkError>) in
            self?.setLoading(false)
            switch result {
            case .success(let movie):
                self?.delegate?.handleOutput(.popularMovies(movie.results ?? []))
            case .failure(let error):
                self?.delegate?.handleOutput(.error(error))
            }
        }
        
        service.fetchData(.trendingTv) {[weak self] (result: Result<Movie, NetworkError>) in
            switch result {
            case .success(let tv):
                self?.delegate?.handleOutput(.trendingTv(tv.results ?? []))
            case .failure(let failure):
                print(failure)
            }
        }
    }
    func setLoading(_ isLoading: Bool) {
        self.delegate?.handleOutput(.setLoading(isLoading))
    }

}
