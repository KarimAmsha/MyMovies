//
//  UINavigationBar+Extensions.swift
//  MyMovies
//
//  Created by Karim Amsha on 17.06.2023.
//

import UIKit

extension UINavigationBar {
    
    class func setupAppearance() {
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: Utilities.appFont(.medium, size: 17)]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ColorManager.primary?.cgColor ?? UIColor.white.cgColor, ColorManager.lightPrimary?.cgColor ?? UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 1, height: 1) // Set the frame of the gradient layer



        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        let renderer = UIGraphicsImageRenderer(bounds: gradientLayer.bounds)
        let backgroundImage = renderer.image { rendererContext in
            gradientLayer.render(in: rendererContext.cgContext)
        }

        appearance.backgroundImage = backgroundImage
        appearance.titleTextAttributes = textAttributes
        appearance.largeTitleTextAttributes = textAttributes
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear

        self.appearance().standardAppearance = appearance
        self.appearance().compactAppearance = appearance
        self.appearance().scrollEdgeAppearance = appearance
        self.appearance().tintColor = .black
        self.appearance().shadowImage = UIImage()
        self.appearance().prefersLargeTitles = false
    }
}
