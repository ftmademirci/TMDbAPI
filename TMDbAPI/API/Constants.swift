//
//  Constants.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 16.10.2020.
//

struct Constants {
    
    //The API's base URL
    static let baseUrl = "https://api.themoviedb.org/3"
    static let apikey = "8ba73029916a2a773293dc235307ca2e"
    static let imageUrl = "https://image.tmdb.org/t/p/w500"
    
    static let colorPrimary = "#1B1B1B"
    static let colorSecondary = "#191919"

    //The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }

    
}
