//
//  RealmService.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 22.03.2024.
//

import Foundation
import RealmSwift

class RealmService {
    private var realm: Realm
    
    init() {
        self.realm = try! Realm()
        print("Realm Database Location: \(realm.configuration.fileURL!)")
    }
    
    //add Movie
    func addMovie(movie: MovieResult) {
         movie.toRealmMovie { realmMovie in
            try! self.realm.write({
                self.realm.add(realmMovie)
            })
        }
    }
    //get movies to realm
    func getMoviesRealm() -> [RealmMovieObject] {
        return Array(realm.objects(RealmMovieObject.self))
    }
    
    //delete movie to realm
    func deleteMovieRealm(movie: RealmMovieObject) {
        try! realm.write({
            realm.delete(movie)
        })
    }
}
