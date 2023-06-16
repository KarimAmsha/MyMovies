//
//  APIEndpoint.swift
//  MyMovies
//
//  Created by Karim Amsha on 16.06.2023.
//

import Alamofire

enum APIEndpoint {
    case popularMovies(page: Int)
    case movieDetails(movieId: Int)

    var path: String {
        switch self {
        case .popularMovies(let page):
            return "/tv/popular?language=en-US&page=\(page)"
        case .movieDetails(let movieId):
            return "/movies/\(movieId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .popularMovies, .movieDetails:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .popularMovies, .movieDetails:
            return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .popularMovies, .movieDetails:
            return [
                "accept": "application/json",
                "Authorization": "Bearer \(Constants.accessToken)"
            ]
        }
    }
    
    var body: Data? {
        switch self {
        case .popularMovies, .movieDetails:
            return nil
        }
    }
}

