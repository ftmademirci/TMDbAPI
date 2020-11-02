//
//  MovieCast.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 20.10.2020.
//

struct MovieCast: Codable {
    
    var cast: [Cast]?
}

struct Cast: Codable {
    
    let credit_id: String?
    let id: Int?
    let name: String?
    let order: Int?
    let profile_path: String?
    let character: String?
}
