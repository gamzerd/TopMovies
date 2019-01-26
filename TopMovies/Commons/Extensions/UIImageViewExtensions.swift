//
//  UIImageViewExtensions.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(with url: String) {
        guard let imageURL = URL(string: url) else { return }
        setImage(with: imageURL)
    }
    
    private func setImage(with url: URL) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil,
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async() {
                self.image = image
            }
        }
        dataTask.resume()
    }
}
