//
//  MoviesVM.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

/**
 The raw value can be used as the section title
 */
enum MovieListType: String {
    case recentSearch = "Recently Searched"
    case nowPlaying = "Now Playing"
}

protocol MoviesVMitem {
    var type: MovieListType {get}
    var cellIdentifier: String {get}
    
    var movies: [MovieDetails] {get set}
}

struct NowPlayingItem: MoviesVMitem {
    let type: MovieListType = .nowPlaying
    let cellIdentifier = String(describing: MovieTableViewCell.self)
    
    var movies: [MovieDetails]
}

struct RecentSearchItem: MoviesVMitem {
    let type: MovieListType = .recentSearch
    let cellIdentifier = String(describing: SearchTableViewCell.self)
    
    var movies: [MovieDetails]
}


class MoviesVM: ObservableObject {
    
    @Published private (set) var movies: [MoviesVMitem] = []
    @Published private (set) var state: FetchingServiceState = .finishedLoading
    
    private (set) var moreMoviesAvailable = false
    
    private (set) var currentPage: Int = 1
    private (set) var totalPages: Int = Int.max
    
    private let apiClient: MoviesAPIclient = APIClient()
    
    //MARK:- Functions
    func fetchMovies() {
        if currentPage > totalPages {return}
        
        let moviesService = MoviesService(parameters: [ParameterKeys.page.rawValue: String(currentPage)])
        
        state = .loading
        apiClient.getMovies(service: moviesService) { (response) in
            DispatchQueue.main.async {
                self.state = .finishedLoading
                switch response {
                case .success(let movies):
                    self.totalPages = movies.totalPages
                    self.currentPage += 1
                    if self.currentPage <= self.totalPages {
                        self.moreMoviesAvailable = true
                    }
                    else {
                        self.moreMoviesAvailable = false
                    }
                    //Get the index for now playing item in the movies array which contains now playing as well as recent search
                    if let index = self.movies.firstIndex(where: {$0.type == .nowPlaying}) {
                        self.movies[index].movies.append(contentsOf: movies.results)
                    }
                    else {
                        //If now playing movies are not there create one and add
                        self.movies.append(NowPlayingItem(movies: movies.results))
                    }
                case .failure(let error):
                    self.state = .error(error)
                }
            }
        }
    }
}
