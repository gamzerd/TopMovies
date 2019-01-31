//
//  MoviesDataSourceTests.swift
//  TopMoviesTests
//
//  Created by Gamze on 1/31/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest

@testable import TopMovies

class MoviesDataSourceTests: XCTestCase {
    
    func testInit() {
        
        let ds = MoviesDataSource()
        XCTAssertNotNil(ds.api)
    }
    
    func testGetMovies() {
        
        // given
        let ds = MoviesDataSource()
        let service = MockService(url: "url/", defaultParams: [:])
        ds.api = service
        
        // when
        var responseReturnedFromCallback: MoviesResponse?
        ds.getMovies(page: 1, callback: { response,_ in
            responseReturnedFromCallback = response
        })
        
        // then
        DispatchQueue.main.async() {
            XCTAssertEqual(service.callCount, 1)
            XCTAssertEqual(service.callParameterPath!, "/movie/popular")
            XCTAssertEqual(responseReturnedFromCallback!.results.count, 2)
            XCTAssertEqual(responseReturnedFromCallback!.results[0].title, "Glass")
            XCTAssertEqual(responseReturnedFromCallback!.results[1].title, "Titanic")
        }
    }
    
}

class MockService: Service {
    
    var callCount = 0
    var callParameterPath: String?
    
    override  func get<E, D>(path: String, params: E, responseType: D.Type, callback: @escaping (D?, Error?) -> Void) where E : Encodable, D : Decodable {
        callCount += 1
        callParameterPath = path
        let list: [Movie] = [Movie(title: "Glass"), Movie(title: "Titanic")]
        let response = MoviesResponse(results: list)
        callback((response as! D), nil)
    }
}



