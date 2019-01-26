//
//  MovieDetailViewModelProtocol.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    
    var movie: Movie { get set }
    
    func getTitle() -> String
    
}
