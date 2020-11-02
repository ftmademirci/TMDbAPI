//
//  MainViewModel.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 15.10.2020.
//

import UIKit

class MainViewModel {
    
    var movies_data: ResultsMovie?
    
    struct Dependencies {
        let api: API
    }
    
    public let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func getMovieData(success: @escaping() -> Void,
                      failure: @escaping (String?) -> Void) {
        dependencies.api.getMovie { (response, error) in
            
            if let error = error {
                failure(error)
            }
            
            if let response = response {
                self.movies_data = response
                success()
            }
        }
    }
    
    func numberOfMovies() -> Int {
        return movies_data?.results?.count ?? 0
    }
    
    func search(mediaType: String, query: String, success: @escaping() -> Void,
                failure: @escaping (String?) -> Void) {
        dependencies.api.search(mediaType: mediaType, query: query) { (response, error) in
            
            if let error = error {
                failure(error)
            }
            
            if let response = response {
                self.movies_data = response
                success()
            }
        }
    }
    
}
