//
//  DataSourceProtocol.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

protocol DataSourceProtocol {
    
    /**
     * Retrieves the movie data from.
     */
    func getMovies(page: Int, callback: @escaping (Array<Movie>?, Error?) -> Void)
}
