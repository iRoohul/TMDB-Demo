//
//  MoviesVM.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

class MoviesVM: ObservableObject {
    
    @Published private (set) var movies: [MovieDetails] = []
    @Published private (set) var state: FetchingServiceState = .finishedLoading
    
    private (set) var currentPage: Int = 1
    private (set) var totalPages: Int = Int.max
    
    private let apiClient: MoviesAPIclient = APIClient()
    
    //MARK:- Functions
    func fetchMovies() {
        if currentPage > totalPages {return}
        
        let moviesService = MoviesService(parameters: [ParameterKeys.page.rawValue: String(currentPage)])
        
        state = .loading
        apiClient.getMovies(service: moviesService) { (response) in
            self.state = .finishedLoading
            switch response {
            case .success(let movies):
                self.movies = movies.results
                self.totalPages = movies.totalPages
                self.currentPage += 1
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }
}
