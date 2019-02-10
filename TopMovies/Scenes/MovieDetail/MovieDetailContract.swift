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

    var id: Int { get set }
    
    func didPageLoad()
    
    func getTitle() -> String
    
    func getFavouriteIconName() -> String
    
    func getPosterPath() -> String
    
    func didFavouriteButtonClick()
    
}

protocol MovieDetailViewProtocol: class {
    
    func showError(message: String)
    
    func invalidateData()
}


