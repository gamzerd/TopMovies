//
//  MovieDetailViewModelTests.swift
//  TopMoviesTests
//
//  Created by Gamze on 2/1/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest
@testable import TopMovies

class MovieDetailViewModelTests: XCTestCase {

    func testInit() {
        
        let ds = MockDataSource()
        let vm = MovieDetailViewModel(dataSource: ds, id: 0)
        
        XCTAssertNotNil(vm.dataSource)
    }
    
    func testGetTitle() {
        
        let ds = MockDataSource()
        let vm = MovieDetailViewModel(dataSource: ds, id: 0)
        vm.movie = FavMovie(title: "Glass")
        
        XCTAssertEqual(vm.getTitle(), "Glass")
    }
    
    func testGetMovie() {
        
        // given
        let ds = MockDataSource()
        ds.expectedMovie = Movie(title: "Glass", id: 12)
        let vm = MovieDetailViewModel(dataSource: ds, id: 12)
        
        let view = MockDetailView()
        vm.viewDelegate = view
        
        // when
        vm.didPageLoad()
        
        // then
        XCTAssertEqual(ds.getMovieCount, 1)
        
        XCTAssertNotNil(vm.id)
        XCTAssertEqual(vm.id, 12)
        
        XCTAssertEqual(view.invalidateDataCount, 1)
    }
    
    func testGetMovieWithError() {
        
        // given
        let ds = MockDataSource()
        let vm = MovieDetailViewModel(dataSource: ds, id: 12)

        let view = MockDetailView()
        vm.viewDelegate = view
        
        // when
        vm.didPageLoad()
        
        // then
        XCTAssertEqual(ds.getMovieCount, 1)
        
        XCTAssertNotNil(vm.id)
        XCTAssertEqual(vm.id, 12)

        XCTAssertEqual(view.showErrorCount, 1)
        XCTAssertEqual(view.showErrorParameter, "Fetching movie failed!")
    }
}

class MockDetailView: MovieDetailViewProtocol {
    
    var invalidateDataCount = 0
    
    var showErrorCount = 0
    var showErrorParameter: String?
    
    func showError(message: String) {
        showErrorCount += 1
        showErrorParameter = message
    }
    
    func invalidateData() {
        invalidateDataCount += 1
    }
    
}
