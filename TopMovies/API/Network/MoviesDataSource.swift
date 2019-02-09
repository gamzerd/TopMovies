//
//  MoviesDataSource.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation
import RxSwift

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
     * @param page: page number to show list.
     * @return [Movie]
     */
    func getMovies(page: Int) -> Observable<[Movie]> {
      
        let requestParams = MoviesRequest(page: String(page))
        
        return Observable<[Movie]>.create { observer in
            self.api.get(path: "/movie/popular", params: requestParams, responseType: MoviesResponse.self, callback:
                { (data: MoviesResponse?, error: Error?) -> Void in
                    if error == nil {
                        observer.onNext((data?.results)!)
                    } else {
                        observer.onError(error!)
                    }
                    observer.onCompleted()
            })

            return Disposables.create {

            }
        }
    }
    
    /**
     * Saves favourite with given id
     * @param id: movie id
     */
    func saveFavourite(id: Int) {
        
        // append new favourite to the list
        var array = defaults.array(forKey: favMovieListIdsKey) as? [Int] ?? [Int]()
        array.append(id)
        
        // update the favourite list in UserDefaults
        defaults.set(array, forKey: favMovieListIdsKey)
        
        // notify all subscribers about the favourite status change
        delegates.forEach { (delegate) in
            delegate.didChangeMovieFavouriteStatus(id: id, isFavourite: true)
        }
    }
    
    /**
     * Deletes favourite with given id
     * @param id: movie id
     */
    func deleteFavourite(id: Int) {
       
        // remove favourite from the list
        var array = defaults.array(forKey: favMovieListIdsKey) as? [Int] ?? [Int]()
        let index = array.firstIndex(of: id)
        if index != nil && index! > -1 {
            array.remove(at: index!)
        }

        // update the favourite list in UserDefaults
        defaults.set(array, forKey: favMovieListIdsKey)
        
        // notify all subscribers about the favourite status change
        delegates.forEach { (delegate) in
            delegate.didChangeMovieFavouriteStatus(id: id, isFavourite: false)
        }
    }
    
    func getFavouritesList() -> Observable<[Int]> {
        
        return Observable.just(defaults.array(forKey: favMovieListIdsKey) as? [Int] ?? [Int]())
    }
    
    func addDelegate(delegate: DataSourceDelegateProtocol) -> Int {
        delegates.append(delegate)
        
        // return the index of the new item. It is used for removing delegate.
        return delegates.count - 1
    }
    
    func removeDelegate(index: Int) {
        delegates.remove(at: index)
    }
}
