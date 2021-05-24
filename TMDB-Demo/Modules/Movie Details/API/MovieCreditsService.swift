//
//  MovieCreditsService.swift
//  TMDB-Demo
//
//  Created by roohulk on 17/05/21.
//

import Foundation

//MARK:- MovieCredits Service
struct CreditsService: Service {
    
    var movieId: String
    var parameters: [String: String]
    
    var path: String {
        EndPoints.credits(id: movieId)
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

protocol MovieCreditsAPIclient {
    func getMovieCredits(service: CreditsService, completion: @escaping (_ result: APIResponse<Credits>) -> ())
}
