//
//  MovieSearchVM.swift
//  TMDB-Demo
//
//  Created by roohulk on 23/05/21.
//


import Foundation

protocol Searchable {
    var searchableString: String {get}
}

extension Array where Element: Searchable {
    
    func searchFilter(with text: String) -> [Element] {
        //If search text is empty no need to filter. When the search field is clear.
        if text.isEmpty {return self}

        //Each word in the search phrase.
        let searchWords = text.split(separator: " ")

        return self.filter {
            for word in searchWords {
                //All the searched words should match with words of the 'searchableString'(AND condition) otherwise its a no match.
                if $0.searchableString.hasAwordBeginning(with: String(word)) {continue}
                return false
            }
            return true
        }
    }
}

extension String {
    
    //Given self = "The Godzila"
    //When text = "the" or text = "gO", it should return true
    //When text = "gd" it should return false
    func hasAwordBeginning(with text: String) -> Bool {
        let words = self.split(separator: " ")
        
        return words.filter {$0.lowercased().hasPrefix(text.lowercased())}.count > 0
    }
}
