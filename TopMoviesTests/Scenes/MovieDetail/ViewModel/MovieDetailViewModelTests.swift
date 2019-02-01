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
        let vm = MovieDetailViewModel(dataSource: ds, movie: FavMovie())
        
        XCTAssertNotNil(vm.dataSource)
        XCTAssertNotNil(vm.movie)
    }
    
    func testGetTitle() {
        
        let ds = MockDataSource()
        let vm = MovieDetailViewModel(dataSource: ds, movie: FavMovie(title: "Glass"))
        
        XCTAssertEqual(vm.getTitle(), "Glass")
    }

}
