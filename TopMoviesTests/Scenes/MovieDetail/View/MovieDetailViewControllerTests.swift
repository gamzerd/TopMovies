//
//  MovieDetailViewControllerTests.swift
//  TopMoviesTests
//
//  Created by Gamze on 2/1/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest
@testable import TopMovies

class MovieDetailViewControllerTests: XCTestCase {

    func testViewDidLoad() {
        
        // given
        let viewModel = MockDetailViewModel()
        let viewController = MovieDetailViewController(viewModel: viewModel)
        
        // when
        _ = viewController.view
        
        // then
        XCTAssertNotNil(viewController.tableView)
    }
    
    func testPageTitle() {
        
        // given
        let viewModel = MockDetailViewModel()
        let viewController = MovieDetailViewController(viewModel: viewModel)
        
        // when
        _ = viewController.view
        
        // then
        XCTAssertEqual(viewController.title, "Movie Detail Test Header")
    }

}

class MockDetailViewModel: MovieDetailViewModelProtocol {
   
    var viewDelegate: MovieDetailViewProtocol?
    
    var movie = FavMovie(title: "Amelie")

    func getFavouriteIconName() -> String {
        return "star"
    }
    
    func didFavouriteButtonClick() {
        
    }
    
    func getTitle() -> String {
        return "Movie Detail Test Header"
    }
}

