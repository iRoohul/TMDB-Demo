//
//  SimilarMoviesService.swift
//  TMDB-Demo
//
//  Created by roohulk on 17/05/21.
//

import Foundation

//MARK:- Similar Movies Service
struct SimilarMoviesService: Service {
    
    var movieId: String
    var parameters: [String: String]
    
    var path: String {
        EndPoints.similar(id: movieId)
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

protocol SimilarMoviesAPIclient {
    func getSimilar(service: SimilarMoviesService, completion: @escaping (_ result: APIResponse<Similar>) -> ())
}
