//
//  MoviesVM.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

enum MovieListType {
    case recentSearch
    case nowPlaying
    case loadMore
}

protocol MoviesVMitem {
    var type: MovieListType {get}
    var cellIdentifier: String {get}
    
    var sectionHeader: String? {get set}
    
    var movies: [MovieDetails?] {get set}
}

struct NowPlayingItem: MoviesVMitem {
    let type: MovieListType = .nowPlaying
    let cellIdentifier = String(describing: MovieTableViewCell.self)
    var sectionHeader: String?
    
    var movies: [MovieDetails?]
}

struct RecentSearchItem: MoviesVMitem {
    let type: MovieListType = .recentSearch
    let cellIdentifier = String(describing: SearchTableViewCell.self)
    var sectionHeader: String?
    
    var movies: [MovieDetails?]
}

struct LoadMoreItem: MoviesVMitem {
    let type: MovieListType = .loadMore
    let cellIdentifier = String(describing: LoadMoreTableViewCell.self)
    var sectionHeader: String?
    
    var movies: [MovieDetails?]
}


class MoviesVM: ObservableObject {
    
    private var allMovies: [MovieDetails] = [] {
        didSet {
            filteredMovies = allMovies
        }
    }
    
    /**
     Movies item will be derived from the filtered list instead of the all movie list. So that filteredMovies becomes ultimate source of truth to load the UI irrespective of whether searching is true or false
     */
    private var filteredMovies: [MovieDetails] = [] {
        didSet {
            //Get the index for now playing item in the movies array which contains now playing as well as recent search
            if let index = self.movies.firstIndex(where: {$0.type == .nowPlaying}) {
                self.movies[index].movies = self.filteredMovies
            }
            else {
                //If now playing movies are not there create one and add
                self.movies.append(NowPlayingItem(movies: self.filteredMovies))
            }
            checkLoadMoreRowStatus()
        }
    }
    
    var searching = false {
        didSet {
            checkLoadMoreRowStatus()
        }
    }
    
    @Published private (set) var movies: [MoviesVMitem] = []
    @Published private (set) var state: FetchingServiceState = .finishedLoading
    
    private (set) var currentPage: Int = 1
    private (set) var totalPages: Int = Int.max
    
    private let apiClient: MoviesAPIclient = APIClient()
    
    //MARK:- Functions
    func fetchMovies() {
        if searching {return}
        if currentPage > totalPages {
            checkLoadMoreRowStatus()
            return
        }
        
        let moviesService = MoviesService(parameters: [ParameterKeys.page.rawValue: String(currentPage)])
        
        state = .loading
        apiClient.getMovies(service: moviesService) { (response) in
            DispatchQueue.main.async {
                self.state = .finishedLoading
                switch response {
                case .success(let movies):
                    self.totalPages = movies.totalPages
                    self.currentPage += 1

                    self.allMovies.append(contentsOf: movies.results)
                case .failure(let error):
                    self.state = .error(error)
                }
            }
        }
    }
    
    //MARK:- Show more row
    private var showLoadMoreRow: Bool {
        searching == false && (currentPage <= totalPages)
    }
    
    private func checkLoadMoreRowStatus() {
        if showLoadMoreRow {
            self.movies.removeAll(where: {$0.type == .loadMore})

            //Adding nil to movies as Load more will need to add 1 row(Load more) at the bottom
            self.movies.append(LoadMoreItem(movies: [nil]))
        }
        else {
            self.movies.removeAll(where: {$0.type == .loadMore})
        }
    }
    
    //MARK:- Search functionality
    
    func search(text: String) {
        filteredMovies = allMovies.searchFilter(with: text)
    }
}
