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
    
    let redAttribute = [NSAttributedString.Key.foregroundColor: UIColor.red]
    let orangeAttribute = [NSAttributedString.Key.foregroundColor: UIColor.orange]
    let greenAttribute = [NSAttributedString.Key.foregroundColor: UIColor.green]
    
    /**
     * Setups cell.
     * @param movie: movie object to set cell.
     */
    func setup(with movie: Movie) {
        
        selectionStyle = .none
        
        title.text = movie.title
        releaseDate.text = movie.releaseDate.formatDate()
        overview.text = movie.overview
        
        poster.setImage(with: AppConstants.API.baseImagePath + movie.posterPath)
        
        var colorAttribute : [NSAttributedString.Key:UIColor] = [:]
        let averageValue = Int(movie.voteAverage * 10)
        
        if averageValue >= 70 {
            colorAttribute = greenAttribute
        } else if averageValue < 40 {
            colorAttribute = redAttribute
        } else {
            colorAttribute = orangeAttribute
        }
        
        let attrString = NSMutableAttributedString(string: String(averageValue) + " %", attributes: colorAttribute)
        let fontAttribute = [NSAttributedString.Key.font: UIFont(name: "Geeza Pro", size: 14.0)! ]
        let range = NSRange(location: 2, length: 2)
        attrString.addAttributes(fontAttribute, range: range)
        
        // set attributed text on a UILabel
       average.attributedText = attrString
    }
}
