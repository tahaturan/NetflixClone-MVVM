//
//  MovieModel.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 6.03.2024.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let page: Int?
    let results: [MovieResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieResult: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let name: String?
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
    }
}
//MARK: - Realm Convert
extension MovieResult {
    func toRealmMovie(completion: @escaping(RealmMovieObject) -> Void) {
        let realmMovie = RealmMovieObject()
        guard let movieID = self.id, let movieTitle = self.title, let movieImageURL = self.posterPath else { return }
        realmMovie.movieID = movieID
        realmMovie.title = movieTitle
        let imageURL = "https://image.tmdb.org/t/p/w500\(movieImageURL)"
        downloadImageData(urlString: imageURL) { data in
            DispatchQueue.main.async {
                realmMovie.movieImage = data
                completion(realmMovie)
            }
        }
    }
    
    private func downloadImageData(urlString: String, comletion: @escaping(Data) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            comletion(data)
        }
        task.resume()
    }
}
