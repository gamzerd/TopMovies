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
     * @param posterPath: poster url of movie.
     */
    func setup(with posterPath: String) {
        poster.setImage(with: AppConstants.API.basePosterPath + posterPath)
    }
}
