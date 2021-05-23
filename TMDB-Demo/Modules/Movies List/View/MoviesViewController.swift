//
//  MoviesViewController.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import UIKit
import Combine

class MoviesViewController: UIViewController {
    
    private let vm: MoviesVM = MoviesVM()
    private var moviesObserver: AnyCancellable?
    private var stateObsrver: AnyCancellable?
    
    private var movies: [MoviesVMitem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        addSearchController()
        
        bindWithVM()
        vm.fetchMovies()
    }
    
    //MARK:- Binding with VM
    
    private func bindWithVM() {
        moviesObserver = vm.$movies.sink(receiveValue: { (movies) in
            self.movies = movies
        })
        
        stateObsrver = vm.$state.sink(receiveValue: { (state) in
            switch state {
            case .loading:
                break
            case .finishedLoading:
                break
            case .error(_):
                break
            }
        })
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieDetailsVC = segue.destination as? MovieDetailsViewController {
            if let movie = sender as? MovieDetails {
                movieDetailsVC.vm = MovieDetailsVM(selectedMovie: movie)
                vm.movieTapped(movie: movie)
            }
        }
    }
}

//MARk:- UITableView handling

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate,MovieTableViewCellDelegate {
    
    //MARK:- UITableView Data source
    func numberOfSections(in tableView: UITableView) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        movies[section].sectionHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies[section].movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = movies[indexPath.section]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: section.cellIdentifier, for: indexPath) as? BaseMovieTableViewCell else {
            fatalError("UNEXPECTED : TableView doesn't have a cell with identifier \(section.cellIdentifier) OR the cell is not a subclass of " + String(describing: BaseMovieTableViewCell.self))
        }
        
        if let movie = section.movies[indexPath.row] {
            cell.configure(with: movie)
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if movies[indexPath.section].type == .loadMore {
            vm.fetchMovies()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: String(describing: MovieDetailsViewController.self), sender: movies[indexPath.section].movies[indexPath.row])
    }
    
    //MARK:- MovieTableViewCellDelegate
    func bookButtonTapped(cell: MovieTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            performSegue(withIdentifier: String(describing: MovieDetailsViewController.self), sender: movies[indexPath.section].movies[indexPath.row])
        }
    }
}

//MARK:- Search Handling

extension MoviesViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    //MARk:- UISearchControllerDelegate
    
    func didPresentSearchController(_ searchController: UISearchController) {
        vm.searchBegins()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        vm.searchEnds()
    }
    
    //MARK:- UISearchResultsUpdating Delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        vm.search(text: text)
    }
    
    //MARK:-  Add functionality
    
    private func addSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movie"
        navigationItem.searchController = searchController
    }
}

