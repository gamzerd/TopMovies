//
//  AppContainerTests.swift
//  TopMoviesTests
//
//  Created by Gamze on 1/31/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest

@testable import TopMovies

class AppContainerTests: XCTestCase {
    
    func testInit() {
        
        let window = UIWindow()
        
        let container = AppContainer(window: window)
        
        XCTAssertNotNil(container.dataSource)
        XCTAssertNotNil(container.router)
    }
}


