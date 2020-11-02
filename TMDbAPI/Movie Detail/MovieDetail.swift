//
//  MovieDetail.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 20.10.2020.
//

struct MovieDetail: Codable {
    
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let runtime: Int?
    let vote_average: Double?
    
}

