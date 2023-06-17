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
    let loadingIndicatorView = LoadingIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    let activityIndicator = ActivityIndicator()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadPopularMovies()
        setupMovieDataSubscription()
    }
    
    func setupUI() {
        setTitle(HomeTitle)
        hideBackWord()
        loadingIndicatorView.center = view.center
        loadingIndicatorView.tintColor = ColorManager.primary!
        view.addSubview(loadingIndicatorView)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(id: MovieCell.self)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    func loadPopularMovies() {
        movieViewModel.fetchPopularMovies()
    }
    
    private func setupMovieDataSubscription() {
        movieViewModel.movies
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] _ in
                DispatchQueue.main.async {
                    self?.loadingIndicatorView.stopAnimation()
                }
            }, onError: { [weak self] _ in
                DispatchQueue.main.async {
                    self?.loadingIndicatorView.stopAnimation()
                }
            }, onSubscribe: { [weak self] in
                DispatchQueue.main.async {
                    self?.loadingIndicatorView.startAnimation()
                }
            })
            .subscribe(onNext: { [weak self] movieResults in
                self?.movies = movieResults
                self?.tableView.reloadData()
            }, onError: { error in
                // Handle the error
                self.showError(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieCell = tableView.dequeueTVCell()
        let movie = movies[indexPath.row]
        cell.item = movie
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let vc: MovieDetailsViewController = AppDelegate.movieDetails.instanceVC()
        vc.movie = movie
        pushNavVC(vc)
    }
}
