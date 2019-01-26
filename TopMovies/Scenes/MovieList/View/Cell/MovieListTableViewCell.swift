//
//  MovieListTableViewCell.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

final class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var average: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    /**
     * Setups cell.
     * @param movie: movie object to set cell.
     */
    func setup(with movie: Movie) {
        
        selectionStyle = .none
        
        title.text = movie.title
        releaseDate.text = movie.releaseDate
        overview.text = movie.overview
        average.text = String(movie.voteAverage) + " %"
        
        poster.setImage(with: movie.posterPath)

    }
}
