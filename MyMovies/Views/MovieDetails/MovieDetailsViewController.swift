//
//  MovieDetailsViewController.swift
//  MyMovies
//
//  Created by Karim Amsha on 17.06.2023.
//

import UIKit
import Cosmos

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var lblDescription: UILabel!
    var movie: MovieResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setMovieInfoDetails()
    }
    
    private func setupUI() {
        // Set the view controller's title
        setTitle(MovieDetails)
    }
    
    /// Fetches movie details and updates the UI.
    private func setMovieInfoDetails() {
        // Check if the movie property is set
        if let movie = movie {
            moviePoster.fetchImage(movie.posterURL) // Fetch and set the movie poster image from URL
            lblTitle.text = movie.name              // Set the movie title
            rateView.rating = movie.voteAverage     // Set the movie rating
            lblDescription.text = movie.overview    // Set the movie description
        }
    }
}


