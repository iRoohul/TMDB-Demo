//
//  MovieDetailsVM.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

class MovieDetailsVM: ObservableObject {
    
    private var movieId: String
    
    init(movieId: String) {
        self.movieId = movieId
    }
    
    func fetchDetails() {
        print("Movie ID\(movieId)")
    }
}
