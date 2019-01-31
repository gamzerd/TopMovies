//
//  MovieListViewModelTests.swift
//  TopMoviesTests
//
//  Created by Gamze on 1/31/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest

@testable import TopMovies

class MovieistViewModelTests: XCTestCase {
    
    func testInit() {
        
        // when
        let vm = MovieListViewModel(dataSource: MockDataSource())
        
        // then
        XCTAssertNotNil(vm.dataSource)
        XCTAssertNotNil(vm.list)
        XCTAssertEqual(vm.list.count, 0)
    }
    
}

enum APIError: Error {
    case NetworkFail()
}

class MockDataSource: DataSourceProtocol {
    
    var getMoviesCount = 0
    var getMoviesParameter: Int?
    
    var saveFavouriteCount = 0
    var saveFavouriteParameter: Int?

    var deleteFavouriteCount = 0
    var deleteFavouriteParameter: Int?
    
    var getFavouritesListCount = 0

    var addDelegateCount = 0
    var addDelegateParameter: DataSourceDelegateProtocol?
    
    var removeDelegateCount = 0
    var removeDelegateParameter: Int?
    
    func getMovies(page: Int, callback: @escaping (MoviesResponse?, Error?) -> Void) {
        getMoviesCount += 1
        getMoviesParameter = page
    }
    
    func saveFavourite(id: Int) {
        saveFavouriteCount += 1
        saveFavouriteParameter = id
    }
    
    func deleteFavourite(id: Int) {
        deleteFavouriteCount += 1
        deleteFavouriteParameter = id
    }
    
    func getFavouritesList() -> [Int] {
        getFavouritesListCount += 1
        return []
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
    var openPageParameter: Movie?
    
    func showList(index: Int) {
        showListCallCount += 1
        showListCallParameter = index
    }
    
    func showError(message: String) {
        showErrorCount += 1
        showErrorParameter = message
    }
    
    func openPage(movie: FavMovie) {
        openPageCount += 1
        openPageParameter = movie
    }
    
}
