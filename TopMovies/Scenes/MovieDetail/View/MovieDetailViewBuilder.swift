//
//  MovieDetailViewBuilder.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

final class MovieDetailBuilder {
    
    static func make(with viewModel: MovieDetailViewModelProtocol) -> MovieDetailViewController {
        let viewController = MovieDetailViewController(viewModel: viewModel)
        return viewController
    }
}
