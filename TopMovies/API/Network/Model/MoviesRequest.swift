//
//  MoviesRequest.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

struct MoviesRequest: Encodable {
    
    var page: String
    
    init(page: String) {
        self.page = page
    }
}
