//
//  MoviesResponse.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

class MoviesResponse: Codable {
    
    var results: Array<Movie>
    
    init(results: Array<Movie>) {
        self.results = results
    }
}
