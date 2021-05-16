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

enum APIResponse<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError: String, Error {
    case badRequest = "Bad request"
    case unauthorized = "Unauthorized access"
    case unknown = "Something went wrong"
    case noJSONData = "No data returned from the server"
    case JSONDecoder = "The data cannot be read because it isn't in the correct format"
}

/**
 Defines the state when there is an Asynchronous API call.
 */
enum FetchingServiceState: Equatable {
    case loading
    case finishedLoading
    case error(NetworkError?)
}
