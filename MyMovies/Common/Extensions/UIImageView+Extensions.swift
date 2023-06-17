//
//  UIImageView+Extensions.swift
//  MyMovies
//
//  Created by Karim Amsha on 17.06.2023.
//

import UIKit
import SDWebImage

extension UIImageView {
    func fetchImage(_ imgURL: URL?, _ placeholder: UIImage = UIImage(systemName: "photo")!) {
        if let imgURL = imgURL {
            self.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.sd_setImage(with: imgURL)
        } else {
            self.image = placeholder
        }
    }
}
