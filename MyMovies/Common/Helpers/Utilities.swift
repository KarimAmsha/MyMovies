//
//  Utilities.swift
//  MyMovies
//
//  Created by Karim Amsha on 17.06.2023.
//

import UIKit

class Utilities: NSObject {
    static func appFont(_ type : fontType = .medium ,size:Int) -> UIFont {
        let font = UIFont(name: type.rawValue, size: CGFloat(size))!
        return font
    }
}
