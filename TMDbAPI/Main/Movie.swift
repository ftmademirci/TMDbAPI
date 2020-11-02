//
//  Movie.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 15.10.2020.
//

struct ResultsMovie: Codable {
    
    var results: [Movie]?
}

struct Movie: Codable {
    
    let poster_path: String?
    let id: Int?
    let original_title: String?
    let vote_average: Double?
    let overview: String?
    let profile_path: String??
    
}
