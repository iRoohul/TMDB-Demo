//
//  RecentSearchHandler.swift
//  TMDB-Demo
//
//  Created by roohulk on 23/05/21.
//

import Foundation

class RecentSearchHandler {
    
    static let shared = RecentSearchHandler()
    private init() {
        getRecentSearched()
    }
    
    let maxResult = 5
    var recentSearchedMovies: [MovieDetails] = []
    
    private let recentlySearchedMoviesCache = NSCache<NSString, MovieCache>()
    
    func addNew(movie: MovieDetails) {
        //If movie is already in the list, just remove it. It will be added at the top as a new entry.
        recentSearchedMovies.removeAll(where: {$0.id == movie.id})
        
        if recentSearchedMovies.count >= maxResult {
            recentSearchedMovies.removeLast()
        }
        recentSearchedMovies.insert(movie, at: 0)
        
        recentlySearchedMoviesCache.setObject(MovieCache(movies: recentSearchedMovies), forKey: cacheKey as NSString)
        if let objevt = recentlySearchedMoviesCache.object(forKey: cacheKey as NSString) {
        }
    }
    
    private let cacheKey = "RecentlySearchedMoviesCache"
    private func getRecentSearched() {
        //Get list from cache
        if let cache = recentlySearchedMoviesCache.object(forKey: cacheKey as NSString) {
            recentSearchedMovies = cache.movies
        }
    }
}


class MovieCache: NSObject {
    var movies: [MovieDetails]
    
     init(movies: [MovieDetails]) {
        self.movies = movies
        
        super.init()
    }
}
