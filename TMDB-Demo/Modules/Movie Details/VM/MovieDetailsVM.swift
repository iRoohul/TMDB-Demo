//
//  MovieDetailsVM.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import UIKit

//MARK:- Row Types

enum MovieDetailType {
    case synopsis
    case similar
    case cast
    case crew
    case review
}

//MARK:- VM Items

//MARK:- MovieDetailVMitem Protocol

protocol MovieDetailVMitem {
//    associatedtype DataType: Decodable
//
//    var data: DataType {get set}
    
    var type: MovieDetailType {get}
    var cellIdentifier: String {get}
    var rowHeight: CGFloat {get}
    var state: FetchingServiceState {get set}
    
    mutating func updateData<T: Codable>(data: T)
//    mutating func updateValues(result: APIResponse<DataType>)
}

//extension MovieDetailVMitem {
//    mutating func updateValues(result: APIResponse<DataType>) {
//        DispatchQueue.main.async {
//            self.state = .finishedLoading
//
//            switch result {
//            case .success(let data):
//                self.data = data
//            case .failure(let error):
//                self.state = .error(error)
//            }
//        }
//    }
//}

//MARK:- Synopsis Item type

struct SynopsisItem: MovieDetailVMitem {
    mutating func updateData<T: Codable>(data: T) {
        if let synopsis = data as? MovieSynopsis {
            self.data = synopsis
        }
    }
    
    
    let type: MovieDetailType = .synopsis
    let cellIdentifier = String(describing: SynopsisTableViewCell.self)
    let rowHeight = UIScreen.main.bounds.width * (750/500)
    var state: FetchingServiceState = .finishedLoading
    
    var data: MovieSynopsis?
}

//MARK:- Similar Item type

struct SimilarItem: MovieDetailVMitem {
    mutating func updateData<T: Codable>(data: T) {
        
    }
    
    var type: MovieDetailType = .similar
    let cellIdentifier = String(describing: SimilarMoviesTableViewCell.self)
    let rowHeight: CGFloat = 200
    var state: FetchingServiceState = .finishedLoading
    
    var data: Similar?
}

//MARK:- Cast Item type

struct CastItem: MovieDetailVMitem {
    mutating func updateData<T: Codable>(data: T) {
        
    }
    
    var type: MovieDetailType = .cast
    let cellIdentifier = String(describing: CreditsTableViewCell.self)
    let rowHeight: CGFloat = 200
    var state: FetchingServiceState = .finishedLoading
    
    var data: [Cast] = []
}

//MARK:- Crew Item type

struct CrewItem: MovieDetailVMitem {
    mutating func updateData<T: Codable>(data: T) {
        
    }
    
    var type: MovieDetailType = .crew
    
    let rowHeight: CGFloat = 200
    var state: FetchingServiceState = .finishedLoading
    let cellIdentifier = String(describing: CreditsTableViewCell.self)
    var data: [Crew] = []
}

//MARK:- Review Item type

struct ReviewsItem: MovieDetailVMitem {
    mutating func updateData<T: Codable>(data: T) {
        
    }
    
    var type: MovieDetailType = .review
    let cellIdentifier = String(describing: ReviewTableViewCell.self)
    let rowHeight: CGFloat = 200
    var state: FetchingServiceState = .finishedLoading
    
    var data: Reviews?
}

//MARK:- View Model

class MovieDetailsVM: ObservableObject {
    
    @Published var vmItem: [MovieDetailVMitem] = [SynopsisItem(), SimilarItem(), CastItem(), CrewItem(), ReviewsItem()]
    
    private (set) var selectedMovie: MovieDetails
    private let apiClient: MovieDetailsAPIClient = APIClient()
    
    init(selectedMovie: MovieDetails) {
        self.selectedMovie = selectedMovie
    }
    
    //MARK:- Functions
    func fetchDetails() {
        fetchSynopsis()
        fetchSimilar()
        fetchCredits()
        fetchReviews()
    }
    
    //MARK:- Synopsis
    private func fetchSynopsis() {
        if let synopsisIndex = vmItem.firstIndex(where: {$0.type == .synopsis}) {
            let service = MovieSynopsisService(movieId: String(selectedMovie.id), parameters: [:])
            
            vmItem[synopsisIndex].state = .loading
            
            apiClient.getMovieSynopsis(service: service) { response in
                
                DispatchQueue.main.async {
                    self.vmItem[synopsisIndex].state = .finishedLoading
                    
                    switch response {
                    case .success(let movie):
                        self.vmItem[synopsisIndex].updateData(data: movie)
                    case .failure(let error):
                        self.vmItem[synopsisIndex].state = .error(error)
                    }
                }
            }
        }
    }
    
    //MARK:- Credits
    private func fetchCredits() {
//        let service = CreditsService(movieId: String(selectedMovie.id), parameters: [:])
//
//        state.creditsState = .loading
//        apiClient.getMovieCredits(service: service) { response in
//
//            DispatchQueue.main.async {
//                self.state.creditsState = .finishedLoading
//
//                switch response {
//                case .success(let credits):
//                    self.vmItem.credits = credits
//                case .failure(let error):
//                    self.state.creditsState = .error(error)
//                }
//            }
//        }
    }

    //MARK:- Similar
    private func fetchSimilar() {
//        let service = SimilarMoviesService(movieId: String(selectedMovie.id), parameters: [:])
//
//        state.similarState = .loading
//        apiClient.getSimilar(service: service) { response in
//
//            DispatchQueue.main.async {
//                self.state.similarState = .finishedLoading
//
//                switch response {
//                case .success(let similar):
//                    self.vmItem.similar = similar
//                case .failure(let error):
//                    self.state.similarState = .error(error)
//                }
//            }
//        }
    }

    //MARK:- Reviews
    private func fetchReviews() {
//        let service = ReviewsService(movieId: String(selectedMovie.id), parameters: [:])
//
//        state.reviewsState = .loading
//        apiClient.getMovieReviews(service: service) { response in
//
//            DispatchQueue.main.async {
//                self.state.reviewsState = .finishedLoading
//
//                switch response {
//                case .success(let reviews):
//                    self.vmItem.reviews = reviews
//                case .failure(let error):
//                    self.state.reviewsState = .error(error)
//                }
//            }
//        }
    }
}
