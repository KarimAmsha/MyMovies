//
//  MoviesViewModel.swift
//  MyMovies
//
//  Created by Karim Amsha on 16.06.2023.
//

import Foundation
import RxSwift

/// The MovieViewModel class is responsible for fetching movie data from the API and managing the state of the movie list.
class MovieViewModel {

    /// A DisposeBag instance to hold disposable resources.
    private let disposeBag = DisposeBag()

    /// A shared instance of the APIClient to make API requests.
    private let apiClient = APIClient.shared

    /// A PublishSubject that will emit an array of MovieResult items whenever the movie list is updated.
    var movies: PublishSubject<[MovieResult]> = PublishSubject()

    /// Fetches popular movies from the API and updates the `movies` PublishSubject with the results.
    ///
    /// This function will make an API request to the popular movies endpoint, parse the response, and update the
    /// `movies` PublishSubject with the new movie list. In case of an error, it will print the error message.
    func fetchPopularMovies() {
        // Define the API endpoint for fetching popular movies
        let popularMoviesEndpoint = APIEndpoint.popularMovies(page: 1)

        // Make a request to the API endpoint, map the response to an array of MovieResult items, and subscribe to the result
        apiClient.request(endpoint: popularMoviesEndpoint)
            .map { (response: Movie) -> [MovieResult] in
                // Extract and return the movie results from the response data
                return response.results
            }
            .subscribe(onNext: { [weak self] response in
                // Update the movies subject with the response data
                self?.movies.onNext(response)
            }, onError: { error in
                // Handle the error by printing it
                print(error)
                // Handle the error by showing in alert
                Utilities.topVC().showError(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
