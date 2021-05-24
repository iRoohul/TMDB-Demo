//
//  MovieSynopsisService.swift
//  TMDB-Demo
//
//  Created by roohulk on 17/05/21.
//

import Foundation

//MARK:- MovieSynopsis Service
struct MovieSynopsisService: Service {
    
    var movieId: String
    var parameters: [String: String]
    
    var path: String {
        EndPoints.movieDetails(id: movieId)
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

protocol MovieSynopsisAPIclient {
    func getMovieSynopsis(service: MovieSynopsisService, completion: @escaping (_ result: Result<MovieSynopsis, NetworkError>) -> ())
}
