//
//  APIError.swift
//  MyMovies
//
//  Created by Karim Amsha on 17.06.2023.
//

enum APIError: Error {
    case invalidResponse
    case networkError
    case parsingError
    
    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return "Invalid response from the server"
        case .networkError:
            return "Network error occurred"
        case .parsingError:
            return "Error occurred while parsing the response"
        }
    }
}
