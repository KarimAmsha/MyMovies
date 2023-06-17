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
    
    var item: MovieResult? {didSet{setData()}}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData() {
        if let item = item {
            poster.fetchImage(item.posterURL)
            lblMovieTitle.text = item.name
            rateView.isUserInteractionEnabled = false
            rateView.rating = item.voteAverage
        }
    }
}
