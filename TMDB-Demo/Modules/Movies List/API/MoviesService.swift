//
//  MoviesService.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

struct MoviesService: Service {
    
    var baseURL: URL? {
        URLs.baseURL.url
    }

    var path: String {
        EndPoints.nowPlaying()
    }

    var headers: RequestHeaders? {
        Parameters.defaultRequestHeaders
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
    func getMovies(service: Service, completion: @escaping (_ result: APIResponse<Movies>) -> ())
}


