//
//  Credits.swift
//  TMDB-Demo
//
//  Created by roohulk on 16/05/21.
//

import Foundation

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
    let profilePath: String
    let castID: Int
    let character, creditID: String
    let order: Int

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
    let profilePath, creditID, department, job: String

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

