//
//  NetworkConstants.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 6.03.2024.
//

import Foundation


protocol EndPointProtocol {
    var baseURL: String { get }
    var genreURL: String { get }
    var apiKey: String { get }
    var method: HTTPMethod { get }
    
    func movieApiURL() -> String
    func request() -> URLRequest
}
enum NetworkError: String, Error {
    case invalidURL
    case canNotProcessData
    case unknownError
    case invalidData
    case decodingError
    case unableToComplateError
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "invalid URL (Gecersiz URL)"
        case .canNotProcessData:
            return "Can Not Process Data (Veri islenemedi)"
        case .unknownError:
            return "Unknown Error (Bilinmeyen Hata)"
        case .invalidData:
            return "invalid Data (Gecersiz Data)"
        case .decodingError:
            return "Decoding Error (Data Decode edilemedi)"
        case .unableToComplateError:
            return "Unable To Complate Error (islem tamamlanamadi Hata)"
        }
    }
}
enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

enum EndPoint {
    case popular
    case topRated
    case upComing
    case trendingTv
    case trendingMovie
    case searchMovie(name:String)
}

extension EndPoint: EndPointProtocol {
    var baseURL: String {
        return "https://api.themoviedb.org"
    }
    
    var genreURL: String {
        switch self {
        case .popular:
            return "/3/movie/popular?"
        case .topRated:
            return "/3/movie/top_rated?"
        case .upComing:
            return "/3/movie/upcoming?"
        case .trendingTv:
            return "/3/trending/tv/day?"
        case .trendingMovie:
            return "/3/trending/movie/day?"
        case .searchMovie(name: let name):
            return "/3/search/movie?query=\(name)&"
        }
    }
    
    var apiKey: String {
        return "api_key=e40dc646b135a28e88caf13e4da0aec2"
    }
    
    var method: HTTPMethod {
        switch self {
        case .popular:
            return .get
        case .topRated:
            return .get
        case .upComing:
            return .get
        case .trendingTv:
            return .get
        case .trendingMovie:
            return .get
        case .searchMovie(name: _):
            return .get
        }
    }
    
    func movieApiURL() -> String {
        return "\(baseURL)\(genreURL)\(apiKey)"
    }
    
    func request() -> URLRequest {
        guard let apiURL = URLComponents(string: movieApiURL()) else {  fatalError("URL Components is not created") }
        guard let url = apiURL.url else { fatalError("URL is not created") }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
