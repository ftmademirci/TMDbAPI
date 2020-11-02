//
//  MovieDetailViewModel.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 15.10.2020.
//

import UIKit

class MovieDetailViewModel {
    
    var movie_detail_data: MovieDetail?
    var movie_cast: MovieCast?
    var video_data: Videos?
    
    struct Dependencies {
        let api: API
    }
    
    public let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func getMovieDetailData(movieId: Int, success: @escaping() -> Void,
                      failure: @escaping (String?) -> Void) {
        dependencies.api.getMovieDetail(movieId: movieId) { (response, error) in
            
            if let error = error {
                failure(error)
            }
            
            if let response = response {
                self.movie_detail_data = response
                success()
            }
        }
    }
    
    func getCastData(movieId: Int, success: @escaping() -> Void,
                      failure: @escaping (String?) -> Void) {
        dependencies.api.getCast(movieId: movieId) { (response, error) in
            
            if let error = error {
                failure(error)
            }
            
            if let response = response {
                self.movie_cast = response
                success()
            }
        }
    }
    
    func numberOfCast() -> Int {
        return movie_cast?.cast?.count ?? 0
    }
    
    func getVideosData(movieId: Int, success: @escaping() -> Void,
                      failure: @escaping (String?) -> Void) {
        dependencies.api.getVideos(movieId: movieId) { (response, error) in
            
            if let error = error {
                failure(error)
            }
            
            if let response = response {
                self.video_data = response
                success()
            }
        }
    }
    
    func numberOfVideos() -> Int {
        return video_data?.results?.count ?? 0
    }
}
