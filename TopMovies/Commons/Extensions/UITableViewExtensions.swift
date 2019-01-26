//
//  UITableViewExtensions.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(_ cell: UITableViewCell.Type) {
        register(UINib(nibName: cell.identifier, bundle: nil), forCellReuseIdentifier: cell.identifier)
    }
}
