//
//  Utilities.swift
//  MyMovies
//
//  Created by Karim Amsha on 17.06.2023.
//

import UIKit

class Utilities: NSObject {
    /// This function returns a UIFont object based on the provided font type and size.
    static func appFont(_ type : fontType = .medium ,size:Int) -> UIFont {
        let font = UIFont(name: type.rawValue, size: CGFloat(size))!
        return font
    }
    
    ///  Returns the top-most view controller in the current view hierarchy.
    static func topVC() -> UIViewController {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            if var topController = keyWindow.rootViewController {
              while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
              }
              return topController
            }
        }
        return UIViewController()
    }
}
