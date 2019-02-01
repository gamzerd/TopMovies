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
    var defaults = UserDefaults.standard
    
    var delegates: [DataSourceDelegateProtocol] = []

    final let favMovieListIdsKey = "FavouriteMovieListIds"
    
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
    func getMovies(page: Int, callback: @escaping (MoviesResponse?, Error?) -> Void){
        
        let requestParams = MoviesRequest(page: String(page))
        
        self.api.get(path: "/movie/popular", params: requestParams, responseType: MoviesResponse.self, callback:
            { (data: MoviesResponse?, error: Error?) -> Void in
                DispatchQueue.main.async {
                    callback(data, nil)
                }
        })
        
    }
    
    /**
     * Saves favourite with given id
     * @param id: movie id
     */
    func saveFavourite(id: Int) {
        
        var array = getFavouritesList()
        array.append(id)
        
        defaults.set(array, forKey: favMovieListIdsKey)
        
        delegates.forEach { (delegate) in
            delegate.didChangeMovieFavouriteStatus(id: id, isFavourite: true)
        }
    }
    
    /**
     * Deletes favourite with given id
     * @param id: movie id
     */
    func deleteFavourite(id: Int) {
       
        var array = getFavouritesList()
        let index = array.firstIndex(of: id)
        if index != nil && index! > -1 {
            array.remove(at: index!)
        }

        defaults.set(array, forKey: favMovieListIdsKey)
        
        delegates.forEach { (delegate) in
            delegate.didChangeMovieFavouriteStatus(id: id, isFavourite: false)
        }
    }
    
    func getFavouritesList() -> [Int] {
        return defaults.array(forKey: favMovieListIdsKey) as? [Int] ?? [Int]()
    }
    
    func addDelegate(delegate: DataSourceDelegateProtocol) -> Int {
        delegates.append(delegate)
        return delegates.count - 1
    }
    
    func removeDelegate(index: Int) {
        delegates.remove(at: index)
    }
}
