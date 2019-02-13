//
//  MovieDetailViewModel.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation
import RxSwift

final class MovieDetailViewModel: MovieDetailViewModelProtocol, DataSourceDelegateProtocol {
    
    var dataSource: DataSourceProtocol
    var id: Int
    weak var viewDelegate: MovieDetailViewProtocol?
    
    var delegateIndex = 0
    
    var movie: FavMovie?
    
    // used to unsubscribe from RxSwift updates when deinit is called
    var disposeBag = DisposeBag()
    
    init(dataSource: DataSourceProtocol, id: Int) {
        self.dataSource = dataSource
        self.id = id
        
        // subscribe for changes in favourite list
        delegateIndex = dataSource.addDelegate(delegate: self)
    }
   
    func didPageLoad() {
 
        Observable.zip(
            // get favourite list
            dataSource.getFavouritesList(),
            
            // get movie
            dataSource.getMovie(id: id),
            
            // consume the result of two async actions
            resultSelector: { favIdList, movie in
                self.movie = FavMovie.initFromMovie(movie: movie, isFavourite: favIdList.contains(self.id))
        }).observeOn(MainScheduler.instance)
            .subscribe(onError: {_ in
                self.viewDelegate?.showError(message: "Fetching movie failed!")
            }, onCompleted: {
                self.viewDelegate?.invalidateData()
            }).disposed(by: self.disposeBag)
        
    }
    
    /**
     * Called to get title.
     */
    func getTitle() -> String {
        
        if let movie = self.movie {
            return movie.title
        } else {
            return ""
        }
    }
    
    /**
     * Called to get poster path.
     */
    func getPosterPath() -> String {
        
        if let movie = self.movie {
            return movie.posterPath
        } else {
            return ""
        }
    }
    
    func didFavouriteButtonClick() {
        
        guard let movieItem = self.movie else { return }
        
        if movieItem.isFavourite {
            dataSource.deleteFavourite(id: movieItem.id)
            movieItem.isFavourite = false
        } else {
            dataSource.saveFavourite(id: movieItem.id)
            movieItem.isFavourite = true
        }
    }
    
    func getFavouriteIconName() -> String {
        
        if let movie = self.movie, movie.isFavourite {
            return "star"
        } else {
            return "starEmpty"
        }
    }
    
    func didChangeMovieFavouriteStatus(id: Int, isFavourite: Bool) {
        viewDelegate?.invalidateData()
    }
    
    deinit {
        
        // unsubscribe for changes in favourite list
        dataSource.removeDelegate(index: delegateIndex)
    }
    
}
