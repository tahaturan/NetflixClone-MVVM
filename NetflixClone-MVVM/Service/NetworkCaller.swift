//
//  NetworkCaller.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 6.03.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T:Codable>(_ endPoint: EndPoint, completion: @escaping(Result<T,NetworkError>) -> Void)
}

final class NetworkCaller: NetworkServiceProtocol {
    
    func fetchData<T:Codable>(_ endPoint: EndPoint, completion: @escaping (Result<T,NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: endPoint.request()) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplateError))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 100, response.statusCode <= 299 else { return  }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoderData =  try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoderData))
            } catch  {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
