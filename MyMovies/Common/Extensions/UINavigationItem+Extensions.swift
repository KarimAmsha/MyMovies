//
//  UINavigationItem+Extensions.swift
//  MyMovies
//
//  Created by Karim Amsha on 17.06.2023.
//

import UIKit

extension UINavigationItem {
    func hideBackWord()  {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.backBarButtonItem = backItem
    }
}
