//
//  MovieDetailViewModel.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    var movie: FavMovie
    
    init(movie: FavMovie) {
        self.movie = movie
    }
    
    /**
     * Called to get title.
     */
    func getTitle() -> String {
        
        return self.movie.title
    }
}
