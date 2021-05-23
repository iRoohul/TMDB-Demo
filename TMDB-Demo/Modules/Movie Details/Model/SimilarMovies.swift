//
//  SimilarMovies.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

// MARK: - Similar
struct Similar: Codable {
    let page: Int
    let results: [MovieDetails]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
//struct Result: Codable {
//    let adult: Bool
//    let backdropPath: String?
//    let genreIDS: [Int]
//    let id: Int
//    let originalLanguage, originalTitle, overview, releaseDate: String
//    let posterPath: String?
//    let popularity: Double
//    let title: String
//    let video: Bool
//    let voteAverage: Double
//    let voteCount: Int
//
//    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
//        case genreIDS = "genre_ids"
//        case id
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview
//        case releaseDate = "release_date"
//        case posterPath = "poster_path"
//        case popularity, title, video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//    }
//}
