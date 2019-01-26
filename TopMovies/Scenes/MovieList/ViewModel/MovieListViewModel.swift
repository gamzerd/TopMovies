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
    
    var list: [Movie] = []
    
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
            self.list.append(contentsOf: list)
            viewDelegate?.showList(list: list)
        }
        
        if error != nil {
            viewDelegate?.showError(message: "Fetching list failed!")
        }
    }
    
    func didScrollToBottom() {
        
        currentPageNumber += 1
        dataSource.getMovies(page: currentPageNumber, callback: didReceiveMovies(list:error:))
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
