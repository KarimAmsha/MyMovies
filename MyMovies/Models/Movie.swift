//
//  Movie.swift
//  MyMovies
//
//  Created by Karim Amsha on 16.06.2023.
//

import Foundation

// Movie Model
struct Movie: Codable {
    let page: Int
    let results: [MovieResult]
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}

struct MovieResult: Codable {
    let backdropPath: String?
    let firstAirDate: String
    let genreIds: [Int]
    let id: Int
    let name: String
    let originCountry: [String]
    let originalLanguage: String
    let originalName: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIds = "genre_ids"
        case id
        case name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var posterURL: URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        
        let baseURL = "https://image.tmdb.org/t/p/"
        let posterSize = "w500"
        // Construct the full URL using the base URL, poster size, and poster path
        return URL(string: baseURL + posterSize + posterPath)
    }
    
    var backdropURL: URL? {
        guard let backdropPath = backdropPath else {
            return nil
        }
        
        let baseURL = "https://image.tmdb.org/t/p/"
        let backdropSize = "w1280"
        // Construct the full URL using the base URL, backdrop size, and backdrop path
        return URL(string: baseURL + backdropSize + backdropPath)
    }
}
