//
//  Movie.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

// movie model
class Movie: Codable {
    
    var title: String = ""
    var id: Int = 0
    var voteAverage: Double = 1.0
    var posterPath: String = ""
    var overview: String = ""
    var releaseDate: Date

    init(title: String = "",
         id: Int = 0,
         voteAverage: Double = 1.0,
         posterPath: String = "",
         overview: String = "",
         releaseDate: Date)
    {
        self.title = title
        self.id = id
        self.voteAverage = voteAverage
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    enum CodingKeys: String, CodingKey {
        case title,
        id,
        voteAverage = "vote_average",
        posterPath = "poster_path",
        overview,
        releaseDate = "release_date"
    }
}
