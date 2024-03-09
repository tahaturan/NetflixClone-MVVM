//
//  HomeViewModelContracts.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 6.03.2024.
//

import Foundation
//["Trending Movies", "Trending Tv","Upcoming Movies", "Top Rated"]
protocol HomeViewModelContracts: AnyObject {
    var delegate: HomeViewModelDelegate? { get set }
    var service: NetworkServiceProtocol { get set}
    func getPopularMovie()
    func getTrendingMovie()
    func getTrendingTv()
    func getUpcomingMovie()
    func getTopRatedMovie()
    func setLoading(_ isLoading: Bool)
}


enum HomeViewModelOutput {
    case popularMovies([MovieResult])
    case upComingMovies([MovieResult])
    case topRatedMovies([MovieResult])
    case trendingTv([MovieResult])
    case trendingMovie([MovieResult])
    case error(Error)
    case setLoading(Bool)
}

protocol HomeViewModelDelegate: AnyObject {
    func handleOutput(_ output: HomeViewModelOutput)
}
