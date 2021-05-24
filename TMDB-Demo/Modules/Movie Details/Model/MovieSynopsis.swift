//
//  MovieSynopsis.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

// MARK: - MovieSynopsis
struct MovieSynopsis: Codable {
    var adult: Bool? = nil
    var backdropPath: String? = nil
    var belongsToCollection: BelongsToCollection? = nil
    var budget: Int? = nil
    var genres: [Genre]
    var homepage: String? = nil
    var id: Int? = nil
    var imdbID: String? = nil
    var originalLanguage: String? = nil
    var originalTitle: String? = nil
    var overview: String? = nil
    var popularity: Double
    var posterPath: String? = nil
    var productionCompanies: [ProductionCompany]? = nil
    var productionCountries: [ProductionCountry]? = nil
    var releaseDate: String? = nil
    var revenue: Int? = nil
    var runtime: Int? = nil
    var spokenLanguages: [SpokenLanguage]? = nil
    var status: String? = nil
    var tagline: String? = nil
    var title: String? = nil
    var video: Bool? = nil
    var voteAverage: Double
    var voteCount: Int
    
    var imageUrl: String? {
        return Poster(size: .detailsSize, path: posterPath).urlString
    }
    
    var placeholderImageUrl: String? {
        return Poster(size: .listSize, path: posterPath).urlString
    }

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension MovieSynopsis {
    /**
     Synopsis can also be initialised with Movie detail. This is to immediately load the content without waiting for the response.
     */
    init(movie: MovieDetails) {
        backdropPath = movie.backdropPath
        posterPath = movie.posterPath
        originalTitle = movie.originalTitle
        title = movie.title
        genres = []
        releaseDate = movie.releaseDate
        voteCount = movie.voteCount
        voteAverage = movie.voteAverage
        popularity = movie.popularity
    }
}


// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int
    let name, posterPath, backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
    
    /**
     A bullet Symbol (•) before genre name
     */
    var formattedName: String {
        "\u{2022} " + name
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
        let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
