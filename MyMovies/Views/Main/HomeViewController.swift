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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadPopularMovies()
        setupMovieDataSubscription()
    }
    
    /// Sets up the UI elements for the home screen.
    private func setupUI() {
        // Set the view controller's title to the HomeTitle constant value
        setTitle(HomeTitle)

        // Hide the back button text when navigating to another view controller
        hideBackWord()

        // Position the loading indicator at the center of the view
        loadingIndicatorView.center = view.center

        // Add the loading indicator as a subview of the main view
        view.addSubview(loadingIndicatorView)

        // Set the table view's data source and delegate to self (the current view controller)
        tableView.dataSource = self
        tableView.delegate = self

        // Register the MovieCell class for reuse in the table view
        tableView.registerCell(id: MovieCell.self)

        // Set an empty UIView as the table footer view to hide any empty cells
        tableView.tableFooterView = UIView()

        // Remove the default separator lines between table view cells
        tableView.separatorStyle = .none
    }
    
    /// Load popular movies by fetching them from the `MovieViewModel`.
    private func loadPopularMovies() {
        // Fetch popular movies from the view model
        movieViewModel.fetchPopularMovies()
    }
    
    private func setupMovieDataSubscription() {
        // Check if the device has an active network connection
        guard isConnectedToNetwork() else {
            // If not connected to the network, show an alert indicating lack of internet connectivity
            showAlertNoInternt()
            // Stop the loading indicator animation as there's no data to load
            loadingIndicatorView.stopAnimation()
            return
        }
        
        // Observe changes to the `movies` property of the `movieViewModel` object.
        movieViewModel.movies
            // Ensure that the changes are observed on the main thread, as they will affect the UI.
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] _ in
                // Dispatch the code block to the main queue to update the UI.
                DispatchQueue.main.async {
                    // Stop the loading animation of the `loadingIndicatorView` object.
                    self?.loadingIndicatorView.stopAnimation()
                }
            }, onError: { [weak self] _ in
                // Dispatch the code block to the main queue to update the UI.
                DispatchQueue.main.async {
                    // Stop the loading animation of the `loadingIndicatorView` object.
                    self?.loadingIndicatorView.stopAnimation()
                }
            }, onSubscribe: { [weak self] in
                // Dispatch the code block to the main queue to update the UI.
                DispatchQueue.main.async {
                    // Start the loading animation of the `loadingIndicatorView` object.
                    self?.loadingIndicatorView.startAnimation()
                }
            })
            // Subscribe to the observable, handling onNext and onError events
            .subscribe(onNext: { [weak self] movieResults in
                // When new movie results are received, update the movies data and reload the table view
                self?.movies = movieResults
                self?.tableView.reloadData()
            }, onError: { error in
                // Handle the error
                self.showError(error.localizedDescription)
            })
            // Dispose the subscription when no longer needed, using the disposeBag
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate Conformance
// Extend `HomeViewController` to conform to the `UITableViewDataSource` and `UITableViewDelegate` protocols.
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count // Return the count of the movies array as the number of rows.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieCell = tableView.dequeueTVCell() // Dequeue a reusable cell of type `MovieCell` from the table view.
        let movie = movies[indexPath.row] // Get the movie object corresponding to the indexPath row.
        cell.item = movie // Assign the movie object to the cell's `item` property.
        return cell // Return the configured cell.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row] // Get the movie object corresponding to the indexPath row.
        let vc: MovieDetailsViewController = AppDelegate.movieDetails.instanceVC() // Instantiate a `MovieDetailsViewController` from the storyboard
        vc.movie = movie // Assign the selected movie object to the `movie` property of the view controller.
        pushNavVC(vc) // Push the `MovieDetailsViewController` onto the navigation stack.
    }
}
