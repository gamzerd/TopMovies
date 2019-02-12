//
//  AppContainer.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation
import UIKit

final class AppContainer {
    
    let router: AppRouter
    let dataSource = MoviesDataSource()
    
    init(window: UIWindow) {
        router = AppRouter(window: window)
    }
}
