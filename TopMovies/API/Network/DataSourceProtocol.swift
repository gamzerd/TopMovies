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
    
    func saveFavourite(id: Int)
    
    func deleteFavourite(id: Int)
    
    func getFavouritesList() -> [Int]
    
    func addDelegate(delegate: DataSourceDelegateProtocol) -> Int
    
    func removeDelegate(index: Int)

}

protocol DataSourceDelegateProtocol: class {
    
    func didChangeMovieFavouriteStatus(id: Int, isFavourite: Bool)
}

