//
//  HomeViewModel.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 12.02.2024.
//

import Foundation
import RealmSwift

final class HomeViewModel: HomeViewModelContracts {
    
    weak var delegate: HomeViewModelDelegate?
    var service: NetworkServiceProtocol
    var realmService: RealmService = RealmService()
    
    init(service: NetworkServiceProtocol) {
        self.service = service
    }
    func getPopularMovie() {
        service.fetchData(.popular) {[weak self] (result: Result<Movie,NetworkError>) in
            switch result {
            case .success(let movie):
                self?.delegate?.handleOutput(.popularMovies(movie.results ?? []))
            case .failure(let error):
                self?.delegate?.handleOutput(.error(error))
            }
        }
    }
    
    func getTrendingMovie() {
        service.fetchData(.trendingMovie) {[weak self] (result: Result<Movie, NetworkError>) in
            switch result {
            case .success(let movie):
                self?.delegate?.handleOutput(.trendingMovie(movie.results ?? []))
            case .failure(let error):
                self?.delegate?.handleOutput(.error(error))
            }
        }
    }
    
    func getTrendingTv() {
        service.fetchData(.trendingTv) {[weak self] (result: Result<Movie, NetworkError>) in
            switch result {
            case .success(let tv):
                self?.delegate?.handleOutput(.trendingTv(tv.results ?? []))
            case .failure(let error):
                self?.delegate?.handleOutput(.error(error))
            }
        }
    }
    
    func getUpcomingMovie() {
        service.fetchData(.upComing) {[weak self] (result: Result<Movie, NetworkError>) in
            switch result {
            case .success(let movie):
                self?.delegate?.handleOutput(.upComingMovies(movie.results ?? []))
            case .failure(let error):
                self?.delegate?.handleOutput(.error(error))
            }
        }
    }
    
    func getTopRatedMovie() {
        service.fetchData(.topRated) {[weak self] (result: Result<Movie, NetworkError>) in
            switch result {
            case .success(let movie):
                self?.delegate?.handleOutput(.topRatedMovies(movie.results ?? []))
            case .failure(let error):
                self?.delegate?.handleOutput(.error(error))
            }
        }
    }
    func loadData() {
        setLoading(true)
        getPopularMovie()
        getTrendingTv()
        getTrendingMovie()
        getUpcomingMovie()
        getTopRatedMovie()
        setLoading(false)
    }
    func setLoading(_ isLoading: Bool) {
        self.delegate?.handleOutput(.setLoading(isLoading))
    }
    func saveMovieRealm(with movie: MovieResult) {
        realmService.addMovie(movie: movie)
    }
}
