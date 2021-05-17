//
//  MovieDetailsVM.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

struct MovieDetailsVMitem {
    var synopsis: MovieSynopsis?
    var reviews: Reviews?
    var credits: Credits?
    var similar: Similar?
}

struct MovieDetailsState {
    var synopsisState: FetchingServiceState = .finishedLoading
    var reviewsState: FetchingServiceState = .finishedLoading
    var creditsState: FetchingServiceState = .finishedLoading
    var similarState: FetchingServiceState = .finishedLoading
}

class MovieDetailsVM: ObservableObject {
    
    private (set) var selectedMovie: MovieDetails
    
    @Published var vmItem: MovieDetailsVMitem = MovieDetailsVMitem()
    @Published var state: MovieDetailsState = MovieDetailsState()
    
    private let apiClient: MovieDetailsAPIClient = APIClient()
    
    init(selectedMovie: MovieDetails) {
        self.selectedMovie = selectedMovie
    }
    
    //MARK:- Functions
    func fetchDetails() {
        fetchSynopsis()
        fetchReviews()
        fetchCredits()
        fetchSimilar()
    }
    
    //MARK:- Synopsis
    private func fetchSynopsis() {
        let service = MovieSynopsisService(movieId: String(selectedMovie.id), parameters: [:])
        
        state.synopsisState = .loading
        apiClient.getMovieSynopsis(service: service) { response in
            
            DispatchQueue.main.async {
                self.state.synopsisState = .finishedLoading
                
                switch response {
                case .success(let movie):
                    self.vmItem.synopsis = movie
                case .failure(let error):
                    self.state.synopsisState = .error(error)
                }
            }
        }
    }
    
    //MARK:- Reviews
    private func fetchReviews() {
        let service = ReviewsService(movieId: String(selectedMovie.id), parameters: [:])
        
        state.reviewsState = .loading
        apiClient.getMovieReviews(service: service) { response in
            
            DispatchQueue.main.async {
                self.state.reviewsState = .finishedLoading
                
                switch response {
                case .success(let reviews):
                    self.vmItem.reviews = reviews
                case .failure(let error):
                    self.state.reviewsState = .error(error)
                }
            }
        }
    }
    
    //MARK:- Credits
    private func fetchCredits() {
        let service = CreditsService(movieId: String(selectedMovie.id), parameters: [:])
        
        state.creditsState = .loading
        apiClient.getMovieCredits(service: service) { response in
            
            DispatchQueue.main.async {
                self.state.creditsState = .finishedLoading
                
                switch response {
                case .success(let credits):
                    self.vmItem.credits = credits
                case .failure(let error):
                    self.state.creditsState = .error(error)
                }
            }
        }
    }
    
    //MARK:- Similar
    private func fetchSimilar() {
        let service = SimilarMoviesService(movieId: String(selectedMovie.id), parameters: [:])
        
        state.similarState = .loading
        apiClient.getSimilar(service: service) { response in
            
            DispatchQueue.main.async {
                self.state.similarState = .finishedLoading
                
                switch response {
                case .success(let similar):
                    self.vmItem.similar = similar
                case .failure(let error):
                    self.state.similarState = .error(error)
                }
            }
        }
    }
}
