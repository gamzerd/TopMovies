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
        var responseReturnedFromCallback: [Movie]?
        ds.getMovies(page: 1).subscribe(onNext: { list in
            responseReturnedFromCallback = list
        }).dispose()
        
        // then
        XCTAssertEqual(service.callCount, 1)
        XCTAssertEqual(service.callParameterPath!, "/movie/popular")
        XCTAssertEqual(responseReturnedFromCallback!.count, 2)
        XCTAssertEqual(responseReturnedFromCallback![0].title, "Glass")
        XCTAssertEqual(responseReturnedFromCallback![1].title, "Titanic")
    }
    
    func testGetMovie() {
        
        // given
        let ds = MoviesDataSource()
        let service = MockService(url: "url/", defaultParams: [:])
        ds.api = service
        
        // when
        var responseReturnedFromCallback: Movie?
        ds.getMovie(id: 1).subscribe(onNext: { movie in
            responseReturnedFromCallback = movie
        }).dispose()
        
        // then
        XCTAssertEqual(service.callCount, 1)
        XCTAssertEqual(service.callParameterPath!, "/movie/1")
        XCTAssertEqual(responseReturnedFromCallback!.id, 1)
        XCTAssertEqual(responseReturnedFromCallback!.title, "Glass")
    }
    
    func testSaveFavourite() {
       
        // given
        let ds = MoviesDataSource()
        
        let mockDefaults = MockDefaults(returnValueOfArrayFunc: [1, 3])
        ds.defaults = mockDefaults
        
        let delegate1 = MockDataSourceDelegate()
        _ = ds.addDelegate(delegate: delegate1)
        
        let delegate2 = MockDataSourceDelegate()
        _ = ds.addDelegate(delegate: delegate2)
        
        // when
        ds.saveFavourite(id: 2)
        
        // then
        XCTAssertEqual(delegate1.didChangeMovieFavouriteStatusCount, 1)
        XCTAssertEqual(delegate1.didChangeMovieFavouriteStatusParameterId, 2)
        XCTAssertEqual(delegate1.didChangeMovieFavouriteStatusParameterIsFavourite, true)
        
        XCTAssertEqual(delegate2.didChangeMovieFavouriteStatusCount, 1)
        XCTAssertEqual(delegate2.didChangeMovieFavouriteStatusParameterId, 2)
        XCTAssertEqual(delegate2.didChangeMovieFavouriteStatusParameterIsFavourite, true)
        
        XCTAssertEqual(mockDefaults.setValueParameter as? [Int], [1, 3, 2])
        XCTAssertEqual(mockDefaults.setDefaultNameParameter, "FavouriteMovieListIds")
        
    }
    
    func testDeleteFavourite() {
        
        // given
        let ds = MoviesDataSource()
        
        let mockDefaults = MockDefaults(returnValueOfArrayFunc: [1, 3])
        ds.defaults = mockDefaults
        
        let delegate1 = MockDataSourceDelegate()
        _ = ds.addDelegate(delegate: delegate1)
        
        let delegate2 = MockDataSourceDelegate()
        _ = ds.addDelegate(delegate: delegate2)
        
        // when
        ds.deleteFavourite(id: 3)
        
        // then
        XCTAssertEqual(delegate1.didChangeMovieFavouriteStatusCount, 1)
        XCTAssertEqual(delegate1.didChangeMovieFavouriteStatusParameterId, 3)
        XCTAssertEqual(delegate1.didChangeMovieFavouriteStatusParameterIsFavourite, false)
       
        XCTAssertEqual(delegate2.didChangeMovieFavouriteStatusCount, 1)
        XCTAssertEqual(delegate2.didChangeMovieFavouriteStatusParameterId, 3)
        XCTAssertEqual(delegate2.didChangeMovieFavouriteStatusParameterIsFavourite, false)
        
        XCTAssertEqual(mockDefaults.setValueParameter as? [Int], [1])
        XCTAssertEqual(mockDefaults.setDefaultNameParameter, "FavouriteMovieListIds")
    }
    
}

class MockService: Service {
    
    var callCount = 0
    var callParameterPath: String?
    
    override  func get<E, D>(path: String, params: E, responseType: D.Type, callback: @escaping (D?, Error?) -> Void) where E : Encodable, D : Decodable {
        callCount += 1
        callParameterPath = path
        
        if path == "/movie/popular" {
            let list: [Movie] = [Movie(title: "Glass"), Movie(title: "Titanic")]
            let response = MoviesResponse(results: list)
            callback((response as! D), nil)
        } else {
            let movie = Movie(title: "Glass", id: 1)
            callback((movie as! D), nil)
        }
    }
}

class MockDefaults: UserDefaults {
    
    var returnValueOfArrayFunc: [Any]?
    
    var setValueParameter: Any?
    var setDefaultNameParameter: String?
    
    convenience init(returnValueOfArrayFunc: [Any] = []) {
        self.init()
        self.returnValueOfArrayFunc = returnValueOfArrayFunc
    }
    
    override func set(_ value: (Any)?, forKey defaultName: String) {
        setValueParameter = value
        setDefaultNameParameter = defaultName
    }
    
    override func array(forKey defaultName: String) -> [Any]? {
        return returnValueOfArrayFunc
    }
}

class MockDataSourceDelegate: DataSourceDelegateProtocol {
    
    var didChangeMovieFavouriteStatusCount = 0
    var didChangeMovieFavouriteStatusParameterId: Int?
    var didChangeMovieFavouriteStatusParameterIsFavourite: Bool?
    
    func didChangeMovieFavouriteStatus(id: Int, isFavourite: Bool) {
        didChangeMovieFavouriteStatusCount += 1
        didChangeMovieFavouriteStatusParameterId = id
        didChangeMovieFavouriteStatusParameterIsFavourite = isFavourite
    }
    
}



