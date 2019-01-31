//
//  MovieListViewModel.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation
import UIKit

final class MovieListViewModel: MovieListViewModelProtocol, DataSourceDelegateProtocol {
    
    var list: [FavMovie] = []
    
    var currentPageNumber = 1
    
    var delegateIndex = 0
    
    weak var viewDelegate: MovieListViewProtocol?
    
    let dataSource: DataSourceProtocol
    
    init (dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
        delegateIndex = dataSource.addDelegate(delegate: self)
    }
    
    /**
     * Called to get title.
     */
    func getTitle() -> String {
        return "Movie List"
    }
    
    /**
     * Called when a row of the movie list is selected.
     * @param index: index of the selected section.
     */
    func didRowSelect(index: Int) {
        viewDelegate?.openPage(movie: list[index])
    }
    
    /**
     * Called when page is loaded.
     */
    func load() {
        dataSource.getMovies(page: currentPageNumber, callback: didReceiveMovies(list:error:))
    }
    
    /**
     * Called when a movie list is received.
     * @param list: list of movie.
     * @param error: error if service fails.
     */
    func didReceiveMovies(list: Array<Movie>?, error: Error?) {
        
        if let list = list {
            
            let favIdArray = dataSource.getFavouritesList()
            
            let favList = list.map({                
                return FavMovie.initFromMovie(movie: $0, isFavourite: favIdArray.contains($0.id))
            })
            
            self.list.append(contentsOf: favList)
            viewDelegate?.showList(index: -1)
        }
        
        if error != nil {
            viewDelegate?.showError(message: "Fetching list failed!")
        }
    }
    
    func didChangeMovieFavouriteStatus(id: Int, isFavourite: Bool) {
        
        let index = list.firstIndex { (movie) -> Bool in
            return movie.id == id
        }
        if  index != nil && index! > -1 {
            list[index!].isFavourite = isFavourite
            viewDelegate?.showList(index: index!)
        }
    }
    
    func didScrollToBottom() {
        
        currentPageNumber += 1
        dataSource.getMovies(page: currentPageNumber, callback: didReceiveMovies(list:error:))
    }

    func didFavouriteButtonClick(index: Int) {
     
        if list[index].isFavourite {
            dataSource.deleteFavourite(id: list[index].id)
        } else {
            dataSource.saveFavourite(id: list[index].id)
        }
        viewDelegate?.showList(index: index)
    }
    
    /**
     * Called when cell pressed long.
     * @param index: index of the selected section's row.
     * @return MovieDetailViewController: controller to show
     */
    func didPressLong(index: Int) -> UIViewController {
        
        let detailViewModel = MovieDetailViewModel(dataSource: app.dataSource, movie: list[index])
        return MovieDetailBuilder.make(with: detailViewModel)
    }
    
    deinit {
        dataSource.removeDelegate(index: delegateIndex)
    }
}
