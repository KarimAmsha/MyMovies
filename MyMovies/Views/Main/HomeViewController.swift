//
//  HomeViewController.swift
//  MyMovies
//
//  Created by Karim Amsha on 16.06.2023.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let movieViewModel = MovieViewModel()
    private var movies: [MovieResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        movieViewModel.fetchPopularMovies()
        
        movieViewModel.movies
            .subscribe(onNext: { [weak self] movieResults in
                self?.movies = movieResults
                self?.tableView.reloadData()
            }, onError: { error in
                // Handle the error
                print(error)
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        let movie = movies[indexPath.row]
        // Configure the cell with the movie data
        cell.textLabel?.text = movie.name
        cell.detailTextLabel?.text = movie.overview
        return cell
    }
}

