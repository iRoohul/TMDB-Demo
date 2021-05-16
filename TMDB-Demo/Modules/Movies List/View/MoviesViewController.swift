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
    
    private var movies: [MovieDetails] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindWithVM()
        vm.fetchMovies()
    }
    
    //MARK:- Binding with VM
    
    private func bindWithVM() {
        moviesObserver = vm.$movies.sink(receiveValue: { (movies) in
            DispatchQueue.main.async {
                self.movies = movies
            }
        })
        
        stateObsrver = vm.$state.sink(receiveValue: { (state) in
            DispatchQueue.main.async {
                switch state {
                case .loading:
                    break
                case .finishedLoading:
                    break
                case .error(_):
                    break
                }
            }
        })
    }
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = String(describing: MovieTableViewCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MovieTableViewCell else {
            fatalError("Unexpected-> TableView doesn't have a cell with identifier \(identifier)")
        }
        
        cell.configure(with: movies[indexPath.row])
        
        return cell
    }
    
    
}

