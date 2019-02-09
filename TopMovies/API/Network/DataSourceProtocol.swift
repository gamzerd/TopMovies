//
//  DataSourceProtocol.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation
import RxSwift

protocol DataSourceProtocol {
    
    /**
     * Retrieves the movie data from.
     */    
    func getMovies(page: Int) -> Observable<[Movie]>
    
    func saveFavourite(id: Int)
    
    func deleteFavourite(id: Int)
    
    func getFavouritesList() -> Observable<[Int]>
    
    func addDelegate(delegate: DataSourceDelegateProtocol) -> Int
    
    func removeDelegate(index: Int)

}

protocol DataSourceDelegateProtocol: class {
    
    func didChangeMovieFavouriteStatus(id: Int, isFavourite: Bool)
}

