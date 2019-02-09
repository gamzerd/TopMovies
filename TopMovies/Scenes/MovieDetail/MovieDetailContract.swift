//
//  MovieDetailContract.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelProtocol: class{
    
    var viewDelegate: MovieDetailViewProtocol? { get set }

    var movie: FavMovie { get set }
    
    func getTitle() -> String
    
    func getFavouriteIconName() -> String
    
    func didFavouriteButtonClick()
    
}

protocol MovieDetailViewProtocol: class {
    
    func invalidateData()
}


