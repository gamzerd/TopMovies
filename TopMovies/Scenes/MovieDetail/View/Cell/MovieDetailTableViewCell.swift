//
//  MovieDetailTableViewCell.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {
   
    @IBOutlet weak var poster: UIImageView!

    /**
     * Setups cell.
     * @param movie: movie object to set cell.
     */
    func setup(with movie: FavMovie) {
        poster.setImage(with: AppConstants.API.basePosterPath + movie.posterPath)
    }
}
