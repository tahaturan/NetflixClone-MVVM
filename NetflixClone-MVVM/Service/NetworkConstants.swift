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
enum NetworkError: Error {
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
}

extension EndPoint: EndPointProtocol {
    var baseURL: String {
        return "https://api.themoviedb.org/3/movie/"
    }
    
    var genreURL: String {
        switch self {
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .upComing:
            return "upcoming"
        }
    }
    
    var apiKey: String {
        return "?api_key=e40dc646b135a28e88caf13e4da0aec2"
    }
    
    var method: HTTPMethod {
        switch self {
        case .popular:
            return .get
        case .topRated:
            return .get
        case .upComing:
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
