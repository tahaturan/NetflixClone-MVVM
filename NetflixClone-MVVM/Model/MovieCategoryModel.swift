//
//  MovieCategoryModel.swift
//  NetflixClone-MVVM
//
//  Created by Taha Turan on 12.03.2024.
//

import UIKit

struct MovieCategoryModel {
    let categoryName: String
    let categoryImage: UIImage
    
    
    static func dummyData() -> [MovieCategoryModel] {
        let list = [
            MovieCategoryModel(categoryName: "Action", categoryImage: .action),
            MovieCategoryModel(categoryName: "Adventure", categoryImage: .adventure),
            MovieCategoryModel(categoryName: "Comedy", categoryImage: .comedi),
            MovieCategoryModel(categoryName: "Crime & Gangster", categoryImage: .criminal),
            MovieCategoryModel(categoryName: "Drama", categoryImage: .drama),
            MovieCategoryModel(categoryName: "Epics / Hisorical", categoryImage: .epic),
            MovieCategoryModel(categoryName: "Mucical", categoryImage: .mucical),
            MovieCategoryModel(categoryName: "Science Fiction", categoryImage: .fiction)
        ]
        return list
    }
}
