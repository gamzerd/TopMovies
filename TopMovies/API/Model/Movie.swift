//
//  Movie.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

/*
"vote_count":909,
"id":424783,
"video":false,
"vote_average":6.5,
"title":"Bumblebee",
"popularity":376.854,
"poster_path":"\/fw02ONlDhrYjTSZV8XO6hhU3ds3.jpg",
"original_language":"en",
"original_title":"Bumblebee",
"genre_ids":[],
"backdrop_path":"\/hMANgfPHR1tRObNp2oPiOi9mMlz.jpg",
"adult":false,
"overview":"On the run in the year 1987, Bumblebee finds refuge in a junkyard in a small Californian beach town. Charlie, on the cusp of turning 18 and trying to find her place in the world, discovers Bumblebee, battle-scarred and broken. When Charlie revives him, she quickly learns this is no ordinary yellow VW bug.",
"release_date":"2018-12-15"
*/

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
