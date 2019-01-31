//
//  MovieDetailViewModel.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

final class MovieDetailViewModel: MovieDetailViewModelProtocol, DataSourceDelegateProtocol {
   
    var dataSource: DataSourceProtocol
    var movie: FavMovie
    weak var viewDelegate: MovieDetailViewProtocol?

    var delegateIndex = 0
    
    init(dataSource: DataSourceProtocol, movie: FavMovie) {
        self.dataSource = dataSource
        self.movie = movie
        
        delegateIndex = dataSource.addDelegate(delegate: self)
    }
    
    /**
     * Called to get title.
     */
    func getTitle() -> String {
        
        return self.movie.title
    }
    
    func didFavouriteButtonClick() {
        if dataSource.getFavouritesList().contains(movie.id) {
            dataSource.deleteFavourite(id: movie.id)
        } else {
            dataSource.saveFavourite(id: movie.id)
        }
        viewDelegate?.invalidateData()
    }
    
    func getFavouriteIconName() -> String {
         if dataSource.getFavouritesList().contains(movie.id) {
            return "star"
        } else {
            return "starEmpty"
        }
    }
    
    func didChangeMovieFavouriteStatus(id: Int, isFavourite: Bool) {
        viewDelegate?.invalidateData()
    }
    
    deinit {
        dataSource.removeDelegate(index: delegateIndex)
    }

}
