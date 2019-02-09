//
//  MovieListViewModel.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class MovieListViewModel: MovieListViewModelProtocol, DataSourceDelegateProtocol {
    
    var list: [FavMovie] = []
    
    var currentPageNumber = 1
    
    // used to unsubscribe from RxSwift updates when deinit is called
    var disposeBag = DisposeBag()

    var delegateIndex = 0
    
    weak var viewDelegate: MovieListViewProtocol?
    
    let dataSource: DataSourceProtocol
    
    init (dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
        
        // subscribe for changes in favourite list
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
        
        let favIdArray = dataSource.getFavouritesList()
        
        dataSource
            .getMovies(page: currentPageNumber)
            .flatMap{ movies in
                Observable.from(movies)
            }.map { movie in
                self.list.append(FavMovie.initFromMovie(movie: movie, isFavourite: favIdArray.contains(movie.id)))
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onError: {_ in
                self.viewDelegate?.showError(message: "Fetching list failed!")
            }, onCompleted: {
                self.viewDelegate?.showList(index: -1)
            }).disposed(by: self.disposeBag)
    }
    
    /**
     * Called when favourite status changed.
     * @param id: selected movie id.
     * @param isFavourite: bool value of favourite.
     */
    func didChangeMovieFavouriteStatus(id: Int, isFavourite: Bool) {
        
        // find movie index from given id
        let index = list.firstIndex { (movie) -> Bool in
            return movie.id == id
        }
        
        // update movie in the list and show list
        if  index != nil && index! > -1 {
            list[index!].isFavourite = isFavourite
            viewDelegate?.showList(index: index!)
        }
    }
    
    /**
     * Called when user scrolls to bottom
     */
    func didScrollToBottom() {
        
        currentPageNumber += 1
        load()
    }
    
    /**
     * Called when favourite button clicked.
     * @param index: index of selected row
     */
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
     * @param index: index of the selected row.
     * @return MovieDetailViewController: controller to show
     */
    func didPressLong(index: Int) -> UIViewController {
        
        let detailViewModel = MovieDetailViewModel(dataSource: app.dataSource, movie: list[index])
        return MovieDetailBuilder.make(with: detailViewModel)
    }
    
    deinit {
        
        // unsubscribe for changes in favourite list
        dataSource.removeDelegate(index: delegateIndex)
    }
}
