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

fileprivate let similarMoviesRowHeight: CGFloat = 350
fileprivate let castNcrewRowHeight: CGFloat = 300
fileprivate let reviewsRowHeight: CGFloat = 300

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
}

//MARK:- Synopsis Item type

struct SynopsisItem: MovieDetailVMitem {
    mutating func updateData<T: Codable>(data: T) {
        self.data = data as? MovieSynopsis
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
        self.data = data as? Similar
    }
    
    var type: MovieDetailType = .similar
    let cellIdentifier = String(describing: SimilarMoviesTableViewCell.self)
    let rowHeight: CGFloat = similarMoviesRowHeight
    var state: FetchingServiceState = .finishedLoading
    
    var data: Similar?
}

//MARK:- Cast Item type

struct CastItem: MovieDetailVMitem {
    mutating func updateData<T: Codable>(data: T) {
        self.data = data as? [Cast] ?? []
        self.data.sort {$0.popularity > $1.popularity}
    }
    
    var type: MovieDetailType = .cast
    let cellIdentifier = String(describing: CreditsTableViewCell.self)
    let rowHeight: CGFloat = castNcrewRowHeight
    var state: FetchingServiceState = .finishedLoading
    
    var data: [Cast] = []
}

//MARK:- Crew Item type

struct CrewItem: MovieDetailVMitem {
    mutating func updateData<T: Codable>(data: T) {
        self.data = data as? [Crew] ?? []
        self.data.sort {$0.popularity > $1.popularity}
    }
    
    var type: MovieDetailType = .crew
    
    let rowHeight: CGFloat = castNcrewRowHeight
    var state: FetchingServiceState = .finishedLoading
    let cellIdentifier = String(describing: CreditsTableViewCell.self)
    var data: [Crew] = []
}

//MARK:- Review Item type

struct ReviewsItem: MovieDetailVMitem {
    mutating func updateData<T: Codable>(data: T) {
        self.data = data as? Reviews
    }
    
    var type: MovieDetailType = .review
    let cellIdentifier = String(describing: ReviewTableViewCell.self)
    let rowHeight: CGFloat = reviewsRowHeight
    var state: FetchingServiceState = .finishedLoading
    
    var data: Reviews?
}

//MARK:- View Model

class MovieDetailsVM: ObservableObject {
    
    @Published var vmItem: [MovieDetailVMitem] = [SynopsisItem(), SimilarItem(), CastItem(), CrewItem()]
    
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
        if let castIndex = vmItem.firstIndex(where: {$0.type == .cast}), let crewIndex = vmItem.firstIndex(where: {$0.type == .crew}) {
            let service = CreditsService(movieId: String(selectedMovie.id), parameters: [:])
            
            vmItem[castIndex].state = .loading
            vmItem[crewIndex].state = .loading
            
            apiClient.getMovieCredits(service: service) { response in
                
                DispatchQueue.main.async {
                    self.vmItem[castIndex].state = .finishedLoading
                    self.vmItem[crewIndex].state = .finishedLoading

                    switch response {
                    case .success(let credit):
                        self.vmItem[castIndex].updateData(data: credit.cast)
                        self.vmItem[crewIndex].updateData(data: credit.crew)
                    case .failure(let error):
                        self.vmItem[castIndex].state = .error(error)
                        self.vmItem[crewIndex].state = .error(error)
                    }
                }
            }
        }
    }

    //MARK:- Similar
    private func fetchSimilar() {
        if let similarIndex = vmItem.firstIndex(where: {$0.type == .similar}) {
            let service = SimilarMoviesService(movieId: String(selectedMovie.id), parameters: [:])
            
            vmItem[similarIndex].state = .loading
            
            apiClient.getSimilar(service: service) { response in
                
                DispatchQueue.main.async {
                    self.vmItem[similarIndex].state = .finishedLoading
                    
                    switch response {
                    case .success(let movies):
                        self.vmItem[similarIndex].updateData(data: movies)
                    case .failure(let error):
                        self.vmItem[similarIndex].state = .error(error)
                    }
                }
            }
        }
    }

    //MARK:- Reviews
    private func fetchReviews() {}
}
