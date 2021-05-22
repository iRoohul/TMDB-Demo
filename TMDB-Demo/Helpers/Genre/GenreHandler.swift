//
//  Genres.swift
//  TMDB-Demo
//
//  Created by roohulk on 22/05/21.
//

import Foundation

// MARK: - Genres
struct Genres: Codable {
    let genres: [Genre]
}

struct GenreHandler {
    static let shared = GenreHandler()
    private init() {
        getGenreList()
    }
    
    var genres: [Genre] = []
    
    private mutating func getGenreList() {
        //Initialize the Genre list with the local constants Json file. Then get the fresh list from the API and refresh the list
        genres = GenreFetcher.getGenre().genres
    }
}

extension GenreHandler {
    func genreText(for ids: [Int]) -> String {
        //Ids can be like [1, 2, 3]
        let genres = ids.compactMap { id in
            self.genres.filter {$0.id == id}.first
        }
        return genres.map {$0.formattedName}.joined(separator: " ")
    }
}

struct GenreFetcher {
    static func getGenre() -> Genres {
 
        if let path = Bundle.main.path(forResource: "Genre", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
                let genre = try JSONDecoder().decode(Genres.self, from: data)
                return genre
              } catch {
                //As the parsing is done using the local file, error is not handled here.
                print(error)
              }
        }
        return Genres(genres: [])
    }
}
