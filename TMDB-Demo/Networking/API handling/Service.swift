//
//  Service.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

typealias RequestHeaders = [String: String]

protocol Service {
    var baseURL: URL? { get }
    var path: String { get }
    var task: RequestType { get }
    var headers: RequestHeaders? { get }
}

extension Service {
    //MARK:- Default values
    //Default values are set here. As this is going to be the same for all services. If a service has different value, it will override.
    var baseURL: URL? {
        URLs.baseURL.url
    }
    
    var headers: RequestHeaders? {
        Parameters.defaultRequestHeaders
    }
    
    //MARK:- Computed properties
    var fullURL: URL? {
        baseURL?.appendingPathComponent(path)
    }
}
