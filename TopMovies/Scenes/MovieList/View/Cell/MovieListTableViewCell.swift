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
    @IBOutlet weak var favouriteButton: UIButton!
    
    var buttonClosure : (() -> Void)? = nil
    
    @IBAction func favouriteButtonClicked(_ sender: Any) {
        
        if let favouriteButtonClicked = self.buttonClosure {
            favouriteButtonClicked()
        }
    }
    
    let redAttribute = [NSAttributedString.Key.foregroundColor: UIColor.red]
    let orangeAttribute = [NSAttributedString.Key.foregroundColor: UIColor.orange]
    let greenAttribute = [NSAttributedString.Key.foregroundColor: UIColor.green]
    
    /**
     * Setups cell.
     * @param movie: movie object to set cell.
     */
    func setup(with movie: FavMovie) {
        
        selectionStyle = .none
        
        title.text = movie.title
        releaseDate.text = movie.releaseDate.formatDate()
        overview.text = movie.overview
        
        poster.image = nil
        poster.setImage(with: AppConstants.API.baseThumbnailPath + movie.posterPath)
            
        if movie.isFavourite {
            favouriteButton.setImage(UIImage(named: "star"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(named: "starEmpty"), for: .normal)
        }
        
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
        
       average.attributedText = attrString
    }
}
