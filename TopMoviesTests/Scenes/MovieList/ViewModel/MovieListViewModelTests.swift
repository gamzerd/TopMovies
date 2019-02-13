//
//  MovieListViewModelTests.swift
//  TopMoviesTests
//
//  Created by Gamze on 1/31/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest
import RxSwift

@testable import TopMovies

class MovieListViewModelTests: XCTestCase {
    
    func testInit() {
        
        // when
        let ds = MockDataSource()
        let vm = MovieListViewModel(dataSource: ds)
        
        // then
        XCTAssertNotNil(vm.dataSource)
        XCTAssertNotNil(vm.list)
        XCTAssertEqual(vm.list.count, 0)
        
        XCTAssertEqual(ds.addDelegateCount, 1)
    }
    
    func testGetTitle() {
        
        // given
        let vm = MovieListViewModel(dataSource: MockDataSource())
        
        // when, then
        XCTAssertEqual(vm.getTitle(), "Movie List")
    }
    
    func testDidRowSelect() {
        
        // given
        let vm = MovieListViewModel(dataSource: MockDataSource())
        vm.list = [FavMovie(id: 14), FavMovie(id: 15)]
        
        let view = MockView()
        vm.viewDelegate = view
        
        // when
        vm.didRowSelect(index: 0)
        
        // then
        XCTAssertEqual(view.openPageCount, 1)
        XCTAssertNotNil(view.openPageParameter)
        XCTAssertEqual(view.openPageParameter, 14 )
    }
    
    func testGetMovies() {
        
        // given
        let ds = MockDataSource()
        ds.expectedList = [Movie(title: "Glass"), Movie(title:  "Iron Man"), Movie(title: "Amelie")]
        let vm = MovieListViewModel(dataSource: ds)
        
        let view = MockView()
        vm.viewDelegate = view
        
        // when
        vm.load()
        
        // then
        XCTAssertEqual(ds.getMoviesCount, 1)

        XCTAssertNotNil(vm.list)
        XCTAssertEqual(vm.list.count, 3)
        
        XCTAssertEqual(view.showListCallCount, 1)
    }
    
    func testGetMoviesWithError() {
        
        // given
        let ds = MockDataSource()
        let vm = MovieListViewModel(dataSource: ds)
        
        let view = MockView()
        vm.viewDelegate = view
        
        // when
        vm.load()
        
        // then
        XCTAssertEqual(ds.getMoviesCount, 1)
        
        XCTAssertNotNil(vm.list)
        XCTAssertEqual(vm.list.count, 0)
        
        XCTAssertEqual(view.showErrorCount, 1)
        XCTAssertEqual(view.showErrorParameter, "Fetching list failed!")
    }
    
    func testLoad() {
        
        // given
        let ds = MockDataSource()
        let vm = MovieListViewModel(dataSource: ds)
        
        // when
        vm.didScrollToBottom()
        
        // then
        XCTAssertEqual(vm.currentPageNumber, 2)

        XCTAssertEqual(ds.getMoviesCount, 1)

    }
    
    func testDidFavouriteButtonClickIfFavourite() {
        
        // given
        let ds = MockDataSource()
        let vm = MovieListViewModel(dataSource: ds)
        vm.list = [FavMovie(id: 14), FavMovie(id: 15)]
        vm.list[1].isFavourite = true
        
        // when
        vm.didFavouriteButtonClick(index: 1)
        
        // then
        XCTAssertEqual(ds.deleteFavouriteCount, 1)
        XCTAssertEqual(ds.deleteFavouriteParameter, 15)
    }
    
    func testDidFavouriteButtonClickIfNotFavourite() {
        
        // given
        let ds = MockDataSource()
        let vm = MovieListViewModel(dataSource: ds)
        vm.list = [FavMovie(id: 14), FavMovie(id: 15)]
        vm.list[1].isFavourite = false
        
        // when
        vm.didFavouriteButtonClick(index: 1)
        
        // then
        XCTAssertEqual(ds.saveFavouriteCount, 1)
        XCTAssertEqual(ds.saveFavouriteParameter, 15)
    }
    
    func testDidChangeFavouriteMovieStatus() {
        
        // given
        let ds = MockDataSource()
        let vm = MovieListViewModel(dataSource: ds)
        vm.list = [FavMovie(id: 14), FavMovie(id: 15)]
        vm.list[1].isFavourite = false
        
        let view = MockView()
        vm.viewDelegate = view
        
        // when
        vm.didChangeMovieFavouriteStatus(id: 15, isFavourite: true)
        
        // then
        XCTAssertEqual(vm.list[1].isFavourite, true)
        
        XCTAssertEqual(view.showListCallCount, 1)
    }
}

enum APIError: Error {
    case NetworkFail()
}

class MockDataSource: DataSourceProtocol {
   
    // returned as mock response in getMovies function
    var expectedList: [Movie]?
    
    var expectedMovie: Movie?

    var getMoviesCount = 0
    var getMoviesParameter: Int?
    
    var getMovieCount = 0
    var getMovieParameter: Int?
    
    var saveFavouriteCount = 0
    var saveFavouriteParameter: Int?

    var deleteFavouriteCount = 0
    var deleteFavouriteParameter: Int?
    
    var getFavouritesListCount = 0

    var addDelegateCount = 0
    var addDelegateParameter: DataSourceDelegateProtocol?
    
    var removeDelegateCount = 0
    var removeDelegateParameter: Int?
    
    func getMovies(page: Int) -> Observable<[Movie]> {
        getMoviesCount += 1
        getMoviesParameter = page
        
        if let list = expectedList {
            return Observable.just(list)
        } else {
            return Observable.error(APIError.NetworkFail())
        }
    }
    
    func getMovie(id: Int) -> Observable<Movie> {
        getMovieCount += 1
        getMovieParameter = id
        
        if let movie = expectedMovie {
            return Observable.just(movie)
        } else {
            return Observable.error(APIError.NetworkFail())
        }
    }
    
    func saveFavourite(id: Int) {
        saveFavouriteCount += 1
        saveFavouriteParameter = id
    }
    
    func deleteFavourite(id: Int) {
        deleteFavouriteCount += 1
        deleteFavouriteParameter = id
    }
    
    func getFavouritesList() -> Observable<[Int]> {
        getFavouritesListCount += 1
        return Observable.just([])
    }
    
    func addDelegate(delegate: DataSourceDelegateProtocol) -> Int {
        addDelegateCount += 1
        addDelegateParameter = delegate
        return 0
    }
    
    func removeDelegate(index: Int) {
        removeDelegateCount += 1
        removeDelegateParameter = index
    }
    
   
}

class MockView: MovieListViewProtocol {
    
    var showListCallCount = 0
    var showListCallParameter: Int?

    var showErrorCount = 0
    var showErrorParameter: String?
    
    var openPageCount = 0
    var openPageParameter: Int?
    
    func showList(index: Int) {
        showListCallCount += 1
        showListCallParameter = index
    }
    
    func showError(message: String) {
        showErrorCount += 1
        showErrorParameter = message
    }
    
    func openPage(id: Int) {
        openPageCount += 1
        openPageParameter = id
    }
    
}
