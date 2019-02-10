//
//  MovieDetailTableViewCellTests.swift
//  TopMoviesTests
//
//  Created by Gamze on 2/1/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest
@testable import TopMovies

class MovieDetailTableViewCellTests: XCTestCase {
    
    func testSetup() {
        
        // given
        let nib = UINib(nibName: "MovieDetailTableViewCell", bundle: nil)
        let cell = nib.instantiate(withOwner: nil, options: [:]).first as! MovieDetailTableViewCell
        
        // when
        cell.setup(with: "url")
        
        // then
        XCTAssertNotNil(cell.poster)
    }
}
