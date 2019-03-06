//
//  MovieListContract.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation
import UIKit

protocol MovieListViewModelProtocol: class {
    
    var viewDelegate: MovieListViewProtocol? { get set }
    
    var list: [FavMovie] { get set }

    func load()
    
    func getTitle() -> String
    
    func didRowSelect(index: Int)
    
    func didPressLong(index: Int) -> UIViewController
    
    func didScrollToBottom()
    
    func didFavouriteButtonClick(index: Int)
    
    func didAlertButtonClick()
    
}

protocol MovieListViewProtocol: class {
    
    func showList(index: Int)
    
    func openPage(id: Int)

    func showAlert(alertTitle: String, alertMessage: String, buttonTitle: String?)
    
}
