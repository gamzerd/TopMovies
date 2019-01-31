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
        showData()
        tableView.register(MovieDetailTableViewCell.self)
    }
    
    @objc func addTapped() {
        viewModel.didFavouriteButtonClick()
    }
    
    func showData() {
        title = viewModel.getTitle()
        let image = UIImage(named: viewModel.getFavouriteIconName())
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addTapped))
        
        tableView.reloadData()
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    
    func invalidateData() {
        
        showData()
    }
}

extension MovieDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.identifier) as! MovieDetailTableViewCell
        cell.setup(with: viewModel.movie)
        
        return cell
    }
}
