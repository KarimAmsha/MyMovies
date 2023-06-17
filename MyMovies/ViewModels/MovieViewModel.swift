//
//  MoviesViewModel.swift
//  MyMovies
//
//  Created by Karim Amsha on 16.06.2023.
//

import Foundation
import RxSwift

class MovieViewModel {
    private let disposeBag = DisposeBag()
    private let apiClient = APIClient.shared
    
    var movies: PublishSubject<[MovieResult]> = PublishSubject()

    func fetchPopularMovies() {
        let popularMoviesEndpoint = APIEndpoint.popularMovies(page: 1)
        apiClient.request(endpoint: popularMoviesEndpoint)
            .map { (response: Movie) -> [MovieResult] in
                return response.results
            }
            .subscribe(onNext: { [weak self] response in
                // Update the movies subject with the response data
                self?.movies.onNext(response)
            }, onError: { error in
                // Handle the error
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
