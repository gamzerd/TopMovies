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
        
        let window = UIWindow()
        
        let router = AppRouter(window: window)
        
        XCTAssertNotNil(router.window)
    }
    
    func testStart() {
        
        let window = UIWindow()

        let router = AppRouter(window: window)
        
        router.start()
        
        XCTAssertNotNil(router.window.rootViewController)
    }
    
}
