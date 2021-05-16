//
//  Extensions.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

extension Dictionary {
    mutating func append(dict: [Key: Value]){
        for (k, v) in dict {
            self[k] = v
        }
    }
}
