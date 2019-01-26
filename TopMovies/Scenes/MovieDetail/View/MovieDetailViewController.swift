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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.getTitle()
        tableView.register(MovieDetailTableViewCell.self)
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
