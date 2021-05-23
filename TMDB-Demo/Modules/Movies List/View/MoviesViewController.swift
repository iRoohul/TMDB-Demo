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
        if movies.count > 1 {
            return movies[section].type.rawValue
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        //Only for `Now playing` section, add 1 more row(to show loader). Cell for row will add this row at the bottom
        //VM maintains a Bool `showLoadMoreRow` whether to show load more or not.
        (movies[section].type == .nowPlaying && vm.showLoadMoreRow) ? movies[section].movies.count + 1 : movies[section].movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row >= movies[indexPath.section].movies.count {
            print("Fetch movies")
            vm.fetchMovies()
            return tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
        }
        else {
            let identifier = String(describing: MovieTableViewCell.self)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MovieTableViewCell else {
                fatalError("Unexpected-> TableView doesn't have a cell with identifier \(identifier)")
            }
            
            cell.configure(with: movies[indexPath.section].movies[indexPath.row])
            cell.delegate = self
            
            return cell
        }
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
        vm.searching = true
        print("Search begins")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        vm.searching = false
        print("Search Ends")
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

