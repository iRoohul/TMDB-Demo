//
//  MoviesService.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

struct MoviesService: Service {

    var path: String {
        EndPoints.nowPlaying()
    }
    
    var parameters: [String: String]
    
    var task: RequestType {
        parameters.isEmpty ? .plain : .parameters(parameters)
    }
    
    init(parameters: [String: String]) {
        self.parameters = parameters
        self.parameters.append(dict: Parameters.defaultRequestParams)
    }
}

protocol MoviesAPIclient {
    func getMovies(service: MoviesService, completion: @escaping (_ result: APIResponse<Movies>) -> ())
}
