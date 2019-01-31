//
//  AppRouterTests.swift
//  TopMoviesTests
//
//  Created by Gamze on 1/31/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest

@testable import TopMovies

class AppRouterTests: XCTestCase {
    
    func testInit() {
        
        let router = AppRouter()
        
        XCTAssertNotNil(router.window)
    }
    
    func testStart() {
        
        let router = AppRouter()
        router.start()
        
        XCTAssertNotNil(router.window.rootViewController)
    }
    
}
