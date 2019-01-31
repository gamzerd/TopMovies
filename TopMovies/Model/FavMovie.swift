//
//  FavMovie.swift
//  TopMovies
//
//  Created by Gamze on 1/30/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

// movie model
class FavMovie: Movie {
    
    var isFavourite: Bool = false

     convenience init(title: String = "",
                      id: Int = 0,
                      voteAverage: Double = 1.0,
                      posterPath: String = "",
                      overview: String = "",
                      releaseDate: Date,
                      isFavourite: Bool = false) {
        
        self.init(title: title, id: id, voteAverage: voteAverage, posterPath: posterPath, overview: overview, releaseDate: releaseDate)
        self.isFavourite = isFavourite
    }
    
    static func initFromMovie(movie: Movie, isFavourite: Bool) -> FavMovie {
       
        let favMovie = FavMovie(title: movie.title, id: movie.id, voteAverage: movie.voteAverage, posterPath: movie.posterPath, overview: movie.overview, releaseDate: movie.releaseDate, isFavourite: isFavourite)
        return favMovie
    }
}
