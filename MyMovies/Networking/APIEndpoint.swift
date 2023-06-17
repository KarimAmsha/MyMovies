//
//  APIEndpoint.swift
//  MyMovies
//
//  Created by Karim Amsha on 16.06.2023.
//

import Alamofire

enum APIEndpoint {
    case popularMovies(page: Int) // Represents the popular movies API endpoint. The page number of the results to fetch.


    var path: String {
        switch self {
        // case for the popular movies endpoint with a specified page number
        case .popularMovies(let page):
            // returns the corresponding API path for popular movies with the specified page number
            return "/tv/popular?language=en-US&page=\(page)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .popularMovies:
            // For fetching popular movies, use the 'get' HTTP method.
            return .get
        }
    }
    
    /// This computed property returns an optional dictionary of type Parameters.
    /// The purpose of the property is to store any specific parameters that a given API case may require.
    var parameters: Parameters? {
        switch self {
        // In case of the popularMovies API, no additional parameters are required, so it returns nil.
        case .popularMovies:
            return nil
        }
    }
    
    /// This property returns the appropriate HTTP headers for the specific API case.
    var headers: HTTPHeaders? {
        switch self {
        // For the "popularMovies" case, create and return the appropriate headers
        case .popularMovies:
            return [
                // Indicate that the response should be in JSON format
                "accept": "application/json",
                // Include the Bearer token from Constants for authorization
                "Authorization": "Bearer \(Constants.accessToken)"
            ]
        }
    }
}

