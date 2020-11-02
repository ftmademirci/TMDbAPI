//
//  ApiClient.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 16.10.2020.
//

import Foundation
import Alamofire

typealias MovieCallback = (_ data: ResultsMovie?, _ error: String?) -> Void
typealias MovieDetailCallback = (_ data: MovieDetail?, _ error: String?) -> Void
typealias MovieCastCallback = (_ data: MovieCast?, _ error: String?) -> Void
typealias PersonCallback = (_ data: Person?, _ error: String?) -> Void
typealias VideosCallback = (_ data: Videos?, _ error: String?) -> Void


protocol ApiClient {
    func getMovie(callback: @escaping MovieCallback)
    func search(mediaType: String, query: String, callback: @escaping MovieCallback)
    func getMovieDetail(movieId: Int, callback: @escaping MovieDetailCallback)
    func getCast(movieId: Int, callback: @escaping MovieCastCallback)
    func getPersonDetail(personId: Int, callback: @escaping PersonCallback)
    func getVideos(movieId: Int, callback: @escaping VideosCallback)


}

class API: ApiClient {
    
    func getMovie(callback: @escaping MovieCallback) {
        
        Spinner.spin()
        AF.request(Router.getPopularMovies).responseDecodable(of: ResultsMovie.self) { (response) in
            Spinner.stop()
            guard let movies = response.value else {
                callback(nil, response.error?.errorDescription)
                return
            }
            callback(movies, nil)
        }
    }
    
    func search(mediaType: String, query: String, callback: @escaping MovieCallback) {
        Spinner.spin()
        AF.request(Router.search(mediaType: mediaType, text: query)).responseDecodable(of: ResultsMovie.self) { (response) in
            Spinner.stop()
            guard let movies = response.value else {
                callback(nil, response.error?.errorDescription)
                return
            }
            callback(movies, nil)
        }
    }
    
    func getMovieDetail(movieId: Int, callback: @escaping MovieDetailCallback) {
        
        AF.request(Router.getMovieDetail(movieId: movieId)).responseDecodable(of: MovieDetail.self) { (response) in
            guard let movie = response.value else {
                callback(nil, response.error?.errorDescription)
                return
            }
            callback(movie, nil)
        }
    }
    func getCast(movieId: Int, callback: @escaping MovieCastCallback) {
        
        AF.request(Router.getCast(movieId: movieId)).responseDecodable(of: MovieCast.self) { (response) in
            guard let movieCast = response.value else {
                callback(nil, response.error?.errorDescription)
                return
            }
            callback(movieCast, nil)
        }
    }
    
    func getPersonDetail(personId: Int, callback: @escaping PersonCallback) {
        
        AF.request(Router.getPersonDetail(personId: personId)).responseDecodable(of: Person.self) { (response) in
            guard let person = response.value else {
                callback(nil, response.error?.errorDescription)
                return
            }
            callback(person, nil)
        }
    }

    func getVideos(movieId: Int, callback: @escaping VideosCallback) {
        
        AF.request(Router.getVideos(movieId: movieId)).responseDecodable(of: Videos.self) { (response) in
            guard let videos = response.value else {
                callback(nil, response.error?.errorDescription)
                return
            }
            callback(videos, nil)
        }
    }

}

