//
//  DateExtensions.swift
//  TopMovies
//
//  Created by Gamze on 1/26/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

extension Date {
    
    func formatDate(format: String = "MMM dd, yyyy") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: self)
    }
    
}

