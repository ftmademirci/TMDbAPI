//
//  Router.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 16.10.2020.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
        
    case getPopularMovies
    case search(mediaType: String, text: String)
    case getMovieDetail(movieId: Int)
    case getCast(movieId: Int)
    case getPersonDetail(personId: Int)
    case getCredits(creditId: String)
    case getVideos(movieId: Int)
        
        
    func asURLRequest() throws -> URLRequest {
        
        let url = try Constants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        let newURLRequest = urlRequest.description.removingPercentEncoding?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let convertedURL = URL(string: newURLRequest!)
        urlRequest = URLRequest(url: convertedURL!)
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: nil)
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getPopularMovies, .search, .getMovieDetail, .getCast, .getPersonDetail, .getCredits, .getVideos:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getPopularMovies:
            return "/movie/popular?api_key=\(Constants.apikey)"
        case .search(let mediaType, let text):
            return "/search/\(mediaType)?query=\(text)&api_key=\(Constants.apikey)"
        case .getMovieDetail(let movieId):
            return "/movie/\(movieId)?api_key=\(Constants.apikey)"
        case .getCast(let movieId):
            return "/movie/\(movieId)/credits?api_key=\(Constants.apikey)"
        case .getPersonDetail(let personId):
            return "/person/\(personId)?api_key=\(Constants.apikey)"
        case .getCredits(let creditId):
            return "/credit/\(creditId)?api_key=\(Constants.apikey)"
        case .getVideos(let movieId):
            return "/movie/\(movieId)/videos?api_key=\(Constants.apikey)"
        }
    }
}
