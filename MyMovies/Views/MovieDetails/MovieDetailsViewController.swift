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
    
    func setupUI() {
        setTitle(MovieDetails)
    }
    
    func setMovieInfoDetails() {
        if let movie = movie {
            moviePoster.fetchImage(movie.posterURL)
            lblTitle.text = movie.name
            rateView.rating = movie.voteAverage
            lblDescription.text = movie.overview
        }
    }
}
