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
    var fullURL: URL? {
        baseURL?.appendingPathComponent(path)
    }
}
