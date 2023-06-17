//
//  UIStoryboard+Extensions.swift
//  MyMovies
//
//  Created by Karim Amsha on 17.06.2023.
//

import UIKit

extension UIStoryboard {
    func instanceVC<T: UIViewController>() -> T {
        guard let vc = instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
        }
        return vc
    }
}
