//
//  RealmMovieObject.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 22.03.2024.
//

import Foundation
import RealmSwift

class RealmMovieObject: Object {
    @Persisted(primaryKey: true) var movieID: Int?
    @Persisted var title: String?
    @Persisted var movieImage: Data?
    
    convenience init(movieID: Int, title: String, movieImage: Data) {
        self.init()
        self.movieID = movieID
        self.title = title
        self.movieImage = movieImage
    }
}
