//
//  MovieListViewControllerTests.swift
//  TopMoviesTests
//
//  Created by Gamze on 2/1/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import XCTest
@testable import TopMovies

class MovieListViewControllerTests: XCTestCase {

    func testInit() {
        
        // given
        let ds = MockDataSource()
        let vm = MovieListViewModel(dataSource: ds)
        
        // when
        let vc = MovieListViewController(viewModel: vm)
        
        // then
        XCTAssertNotNil(vc.viewModel)
    }
    
    func testViewDidLoad() {
        
        // given
        let ds = MockDataSource()
        let viewModel = MovieListViewModel(dataSource: ds)
        let viewController = MovieListViewController(viewModel: viewModel)
        
        // when
        _ = viewController.view // triggers viewDidLoad
        
        // then
        XCTAssertNotNil(viewController.tableView)
        XCTAssertEqual(viewController.title, "Movie List")
    }
    
    func testRenderWithoutMovies() {
        
        // given
        let ds = MockDataSource()
        let viewModel = MovieListViewModel(dataSource: ds)
        let viewController = MovieListViewController(viewModel: viewModel)
        
        // when
        _ = viewController.view // triggers viewDidLoad
        
        // then
        XCTAssertEqual(viewController.tableView.numberOfItems(), 0)
    }
    
    func testRenderMovies() {
        
        // given
        let ds = MockDataSource()
        let viewModel = MovieListViewModel(dataSource: ds)
        viewModel.list = [FavMovie(title: "Amelie"), FavMovie(title: "Iron Man"), FavMovie(title: "Harry Potter")]
        
        let viewController = MovieListViewController(viewModel: viewModel)
        
        // when
        _ = viewController.view // triggers viewDidLoad
        
        // then
        XCTAssertEqual(viewController.tableView.numberOfItems(), 3)
    }
    
    func testRenderCellForMovies() {
        
        // given
        let ds = MockDataSource()
        let viewModel = MovieListViewModel(dataSource: ds)
        viewModel.list = [FavMovie(title: "Amelie"), FavMovie(title: "Iron Man"), FavMovie(title: "Harry Potter")]
        
        let viewController = MovieListViewController(viewModel: viewModel)
        
        // when
        _ = viewController.view // triggers viewDidLoad
        
        // then
        XCTAssertEqual(viewController.tableView.title(at: 0), "Amelie")
        XCTAssertEqual(viewController.tableView.title(at: 1), "Iron Man")
        XCTAssertEqual(viewController.tableView.title(at: 2), "Harry Potter")
    }
    
    func testOpenPage() {
        
        // given
        let viewModel = MockViewModel()
        let viewController = MovieListViewController(viewModel: viewModel)
        let mockDelegate = MockShowDetailsCoordinatorDelegate()
        viewController.delegate = mockDelegate
        
        // when
        viewController.openPage(movie: FavMovie(title: "Amelie"))
        
        // then
        XCTAssertEqual(mockDelegate.showDetailsCount, 1)
        XCTAssertEqual(mockDelegate.showDetailsParameterMovie?.title, "Amelie")
        XCTAssertEqual(mockDelegate.showDetailsParameterFromViewController, viewController)
        
    }

}

private extension UITableView {
    func numberOfItems() -> Int {
        return numberOfRows(inSection: 0)
    }
    
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        let movieListCell = cell(at: row) as! MovieListTableViewCell
        return movieListCell.title.text
    }
}

class MockViewModel: MovieListViewModelProtocol {
    
    var viewDelegate: MovieListViewProtocol?
    
    var list = [FavMovie]()
    
    var loadCount = 0
    
    func load() {
        loadCount += 1
    }
    
    func getTitle() -> String {
        return "TopMovies Test Header"
    }
    
    func didRowSelect(index: Int) {
        
    }
    
    func didPressLong(index: Int) -> UIViewController {
        return MovieDetailViewController()
    }
    
    func didScrollToBottom() {
        
    }
    
    func didFavouriteButtonClick(index: Int) {
        
    }
    
}

class MockShowDetailsCoordinatorDelegate: ShowDetailsCoordinatorDelegate {
    
    var showDetailsCount = 0
    var showDetailsParameterMovie: FavMovie?
    var showDetailsParameterFromViewController: UIViewController?
    
    func showDetails(movie: FavMovie, fromViewController: UIViewController) {
        showDetailsCount += 1
        showDetailsParameterMovie = movie
        showDetailsParameterFromViewController = fromViewController
    }
}
