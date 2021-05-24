//
//  Network Enums.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

enum RequestType {
    case plain
    case parameters([String: String])
}

enum NetworkError:  Error, Equatable {
    case badRequest
    case unauthorized
    case unknown
    case noJSONData
    case JSONDecoder
    case other(String)
    
    var description: String {
        switch self {
        case .badRequest:
            return "Bad request"
        case .unauthorized:
            return "Unauthorized access"
        case .unknown:
            return "Something went wrong"
        case .noJSONData:
            return "No data returned from the server"
        case .JSONDecoder:
            return "The data cannot be read because it isn't in the correct format"
        case .other(let value):
            return value
        }
    }
}


/**
 Defines the state when there is an Asynchronous API call.
 */
enum FetchingServiceState: Equatable {    
    case loading
    case finishedLoading
    case error(NetworkError?)
}
