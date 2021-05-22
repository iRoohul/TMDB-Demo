//
//  NetworkConstants.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

private let APIkey = "c1aadddc72d45a2059f3eb84b6650ac1"

//MARK:- URLs

enum URLs: String {
    case baseURL = "https://api.themoviedb.org/3"
    case imageBaseURL = "https://image.tmdb.org/t/p"
    
    var url: URL? {
        URL(string: self.rawValue)
    }
}

struct EndPoints {
    static func nowPlaying() -> String {"/movie/now_playing"}
    
    static func movieDetails(id: String) -> String {"/movie/" + id}
    
    static func credits(id: String) -> String {"/movie/\(id)/credits"}
    
    static func similar(id: String) -> String {"/movie/\(id)/similar"}

    static func reviews(id: String) -> String {"/movie/\(id)/reviews"}
    
    static func genreList() -> String {"/genre/movie/list"}
}

//MARK:- Poster sizes

enum PosterSizes: String {
    /**
     W92 size. to be shown on the Movies list screen
     */
    case listSize = "w92"
    
    /**
     w500 size. To be shown on Details screen
     */
    case detailsSize = "w500"
    
    /**
     Original size.
     */
    case original = "original"
}

//MARK:- Poster

struct Poster {
    var size: PosterSizes = .listSize
    var path: String?
    
    var urlString: String? {
        guard let path = path else {return nil}
        return URLs.imageBaseURL.rawValue + "/" + size.rawValue + "/" + path
    }
}

enum ParameterKeys: String {
    case query = "query"
    case page = "page"
}

struct Parameters {
    static let defaultRequestParams = ["api_key": APIkey]
    static let defaultRequestHeaders = ["Content-type": "application/json; charset=utf-8"]
}
