//
//  MoviesDataSource.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

class MoviesDataSource: DataSourceProtocol {
   
    var api: ServiceProtocol
    
    init() {
        self.api = Service(
            url: AppConstants.API.base_url,
            defaultParams: ["api_key": AppConstants.API.api_key]
        )
    }
    
    /**
     * Gets movie from api.
     * @param movie: movie object.
     * @param callback: completion callback.
     */
    func getMovies(page: Int, callback: @escaping (Array<Movie>?, Error?) -> Void){
        
        let requestParams = MoviesRequest(page: String(page))
        
        self.api.get(path: "/movie/popular", params: requestParams, responseType: MoviesResponse.self, callback:
            { (data: MoviesResponse?, error: Error?) -> Void in
                callback(data?.results, nil)
        })
        
    }

}
