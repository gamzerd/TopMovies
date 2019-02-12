//
//  MovieListBuilder.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

final class MovieListBuilder {
    
    static func make() -> MovieListViewController {
        
        let viewModel = MovieListViewModel(dataSource: app!.dataSource)
        let viewController = MovieListViewController(viewModel: viewModel)
        return viewController
        
    }
}
