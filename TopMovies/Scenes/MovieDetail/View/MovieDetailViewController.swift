//
//  MovieDetailViewController.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MovieDetailViewModelProtocol!
    
    convenience init(viewModel: MovieDetailViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.viewDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MovieDetailTableViewCell.self)
        viewModel.didPageLoad()
    }
    
    @objc func favouriteButtonClicked() {
        viewModel.didFavouriteButtonClick()
    }
    
    func showData() {
        title = viewModel.getTitle()
        
        let image = UIImage(named: viewModel.getFavouriteIconName())
        let button = UIButton(type: .custom)
        
        button.setImage((image), for: .normal)
        button.addTarget(self, action: #selector(favouriteButtonClicked), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        tableView.reloadData()
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    
    func invalidateData() {
        
        showData()
    }
    
    /**
     * Called when view model has an error.
     * @param message: to show in alert
     */
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
}

extension MovieDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.identifier) as! MovieDetailTableViewCell
        cell.setup(with: viewModel.getPosterPath())
        
        return cell
    }
}
