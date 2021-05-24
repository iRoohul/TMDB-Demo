//
//  MovieReviewsService.swift
//  TMDB-Demo
//
//  Created by roohulk on 17/05/21.
//

import Foundation

//MARK:- MovieReviews Service
struct ReviewsService: Service {
    
    var movieId: String
    var parameters: [String: String]
    
    var path: String {
        EndPoints.reviews(id: movieId)
    }
    
    var task: RequestType {
        parameters.isEmpty ? .plain : .parameters(parameters)
    }
    
    init(movieId: String, parameters: [String: String]) {
        self.movieId = movieId
        self.parameters = parameters
        self.parameters.append(dict: Parameters.defaultRequestParams)
    }
}

protocol MovieReviewsAPIclient {
    func getMovieReviews(service: ReviewsService, completion: @escaping (_ result: Result<Reviews, NetworkError>) -> ())
}
