//
//  Credits.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

enum Gender: Int {
    case unknown = 0
    case female = 1
    case male = 2
    case other = 3
}

//MARK:- Credits
struct Credits: Codable {
    let id: Int
    let cast: [Cast]
    let crew: [Crew]
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment, name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int
    let character, creditID: String
    let order: Int
    
    var imageUrl: String? {
        Poster(size: .profile, path: profilePath).urlString
    }

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
}

// MARK: - Crew
struct Crew: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment, name, originalName: String
    let popularity: Double
    let profilePath: String?
    let creditID, department, job: String
    
    var imageUrl: String? {
        Poster(size: .profile, path: profilePath).urlString
    }

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case creditID = "credit_id"
        case department, job
    }
}

