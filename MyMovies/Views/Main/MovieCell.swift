//
//  MovieCell.swift
//  MyMovies
//
//  Created by Karim Amsha on 17.06.2023.
//

import UIKit
import Cosmos

class MovieCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    
    var item: MovieResult? {didSet{setData()}} // Update the cell's UI whenever the `item` is set.

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData() {
        // Check if the `item` property is not `nil`.
        if let item = item {
            poster.fetchImage(item.posterURL)           // Fetch and display the movie poster image.
            lblMovieTitle.text = item.name              // Set the movie title label text.
            rateView.isUserInteractionEnabled = false   // Disable user interaction for the rating view.
            rateView.rating = item.voteAverage          // Set the rating view's value.
        }
    }
}


