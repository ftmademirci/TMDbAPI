//
//  PersonDetailViewModel.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 15.10.2020.
//

import UIKit

class PersonDetailViewModel {
    
    var person_data: Person?
    
    struct Dependencies {
        let api: API
    }
    
    public let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func getPersonData(personId: Int, success: @escaping() -> Void,
                      failure: @escaping (String?) -> Void) {
        dependencies.api.getPersonDetail(personId: personId) { (response, error) in
            
            if let error = error {
                failure(error)
            }
            
            if let response = response {
                self.person_data = response
                success()
            }
        }
    }
    
}
