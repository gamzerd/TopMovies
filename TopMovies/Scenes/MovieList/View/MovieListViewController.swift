//
//  ViewController.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: MovieListViewModelProtocol!
    weak var delegate: ShowDetailsCoordinatorDelegate!
    
    convenience init(viewModel: MovieListViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.viewDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.getTitle()
        viewModel.load()
        tableView.register(MovieListTableViewCell.self)
        registerForPreviewing(with: self, sourceView: tableView)
    }
}

extension MovieListViewController: MovieListViewProtocol {
    
    /**
     * Shows movie list.
     * @param list: to show
     */
    func showList(list: Array<Movie>) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    /**
     * Called when view model has an error.
     * @param message: to show in alert
     */
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
    
    /**
     * Opens detail page.
     * @param movie: Object to set details, fromViewController: controller to show detail
     */
    func openPage(movie: Movie) {
        delegate.showDetails(movie: movie, fromViewController: self)
    }
    
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier) as! MovieListTableViewCell
        cell.setup(with: self.viewModel.list[indexPath.row])
        
        if indexPath.row == self.viewModel.list.count - 1 {
            self.viewModel.didScrollToBottom()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didRowSelect(index: indexPath.row)
    }
   
}

extension MovieListViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: location) else {
            return nil
        }
        
        return viewModel.didPressLong(index: indexPath.row)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}


