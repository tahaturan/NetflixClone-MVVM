//
//  DetailViewModel.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 20.03.2024.
//

import Foundation

final class DetailViewModel: DetailViewModelContracts {
    var delegate: DetailViewModelDelegate?
    
    var service: NetworkServiceProtocol
    
    var movieId: Int
    
    init(service: NetworkServiceProtocol, movieId: Int) {
        self.service = service
        self.movieId = movieId
    }
    
    func getMovieDetail() {
        setLoading(true)
        service.fetchData(.getMovieWitdhID(id: movieId)) { [weak self] (result: Result<MovieDetail, NetworkError>) in
            self?.setLoading(false)
            switch result {
            case .success(let movie):
                self?.delegate?.handleOutput(.movie(movie))
            case .failure(let error):
                self?.delegate?.handleOutput(.error(error))
            }
        }
    }
    
    func setLoading(_ isLoading: Bool) {
        self.delegate?.handleOutput(.setLoading(isLoading))
    }
}
