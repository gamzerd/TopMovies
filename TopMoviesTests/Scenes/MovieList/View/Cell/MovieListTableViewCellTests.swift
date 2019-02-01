//
//  MovieListTableViewCellTests.swift
//  TopMoviesTests
//
//  Created by Gamze on 2/1/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest
@testable import TopMovies

class MovieListTableViewCellTests: XCTestCase {

    func testSetup() {
        
        let nib = UINib(nibName: "MovieListTableViewCell", bundle: nil)
        let cell = nib.instantiate(withOwner: nil, options: [:]).first as! MovieListTableViewCell
        
        cell.setup(with: FavMovie(title: "Iron Man", id: 3, voteAverage: 5.4, posterPath: "posterPath", overview: "overview", releaseDate: Date(), isFavourite: false))
        
        XCTAssertNotNil(cell.title)
        XCTAssertEqual(cell.title.text, "Iron Man")
        XCTAssertNotNil(cell.releaseDate)
        XCTAssertNotNil(cell.overview)
        XCTAssertEqual(cell.overview.text, "overview")
        XCTAssertNotNil(cell.average)
        XCTAssertEqual(cell.average.text, "54 %")
    }

}
