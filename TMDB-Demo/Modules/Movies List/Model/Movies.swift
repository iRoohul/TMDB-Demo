//
//  Movies.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

// MARK: - Movies
struct Movies: Codable {
    let page: Int
    let results: [MovieDetails]
    let dates: Dates
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results, dates
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}

// MARK: - MovieDetails
struct MovieDetails: Codable, Searchable {
    var searchableString: String {
        originalTitle
    }
    
    let posterPath: String?
    let adult: Bool
    let overview, releaseDate: String
    let genreIDS: [Int]
    let id: Int
    let originalTitle, originalLanguage, title: String
    let backdropPath: String?
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult, overview
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
    
    var cellImageUrl: String? {
        Poster(size: .listSize, path: posterPath).urlString
    }
    
    var searchCellImageUrl: String? {
        Poster(size: .backdropSize, path: backdropPath).urlString
    }
}
