//
//  Videos.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 21.10.2020.
//

struct Videos: Codable {
    
    var results: [Video]?
}

struct Video: Codable {
    
    let key: String?
    let site: String?
    
}
