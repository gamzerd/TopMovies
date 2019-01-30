//
//  MovieListViewModel.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation
import UIKit

final class MovieListViewModel: MovieListViewModelProtocol {
    
    var list: [FavMovie] = []
    
    var currentPageNumber = 1
    
    weak var viewDelegate: MovieListViewProtocol?
    
    let dataSource: DataSourceProtocol
    
    init (dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
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
            let favList = list.map({
                return FavMovie.initFromMovie(movie: $0)
            })
            
            self.list.append(contentsOf: favList)
            viewDelegate?.showList(index: -1)
        }
        
        if error != nil {
            viewDelegate?.showError(message: "Fetching list failed!")
        }
    }
    
    func didScrollToBottom() {
        
        currentPageNumber += 1
        dataSource.getMovies(page: currentPageNumber, callback: didReceiveMovies(list:error:))
    }

    func didFavouriteButtonClick(index: Int) {
     
        if list[index].isFavourite {
            list[index].isFavourite = false
            dataSource.deleteFavourite()
        } else {
            list[index].isFavourite = true
            dataSource.saveFavourite()
        }
        viewDelegate?.showList(index: index)
    }
    
    /**
     * Called when cell pressed long.
     * @param index: index of the selected section's row.
     * @return MovieDetailViewController: controller to show
     */
    func didPressLong(index: Int) -> UIViewController {
        
        let detailViewModel = MovieDetailViewModel(movie: list[index])
        return MovieDetailBuilder.make(with: detailViewModel)
    }
}
