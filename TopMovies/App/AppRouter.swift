//
//  AppRouter.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

final class AppRouter {
    
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    /**
     * Sets rootViewController.
     */
    func start() {
        let viewController = MovieListBuilder.make()
        viewController.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

protocol ShowDetailsCoordinatorDelegate: class {
    func showDetails(movie: FavMovie, fromViewController: UIViewController)
}

extension AppRouter: ShowDetailsCoordinatorDelegate {
    
    /**
     * Shows details of movie list.
     * @param movie: Object to set details, fromViewController: controller to show detail
     */
    func showDetails(movie: FavMovie, fromViewController: UIViewController) {
        let viewModel = MovieDetailViewModel(movie: movie)
        let movieDetailVC = MovieDetailBuilder.make(with: viewModel)
        fromViewController.show(movieDetailVC, sender: nil)
    }
}
