//
//  UIViewController.swift
//  MyMovies
//
//  Created by Karim Amsha on 17.06.2023.
//

import UIKit
import SwiftMessages
import SystemConfiguration

extension UIViewController {
    func setTitle(_ title: String) {
        navigationItem.title = title
    }

    func showError(_ body: String) {
        let error = MessageView.viewFromNib(layout: .cardView)
        error.configureTheme(.error)
        error.configureContent(title: "Error", body: body)
        error.button?.isHidden = true
        SwiftMessages.show(view: error)
    }

    func showSuccess(_ body: String) {
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.success)
        success.configureDropShadow()
        success.configureContent(title: "Success", body: body)
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .top
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(config: successConfig, view: success)
    }

    func showWarning(_ body: String) {
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.warning)
        warning.configureDropShadow()
        let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
        warning.configureContent(title: "Warning", body: body, iconText: iconText)
        warning.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        SwiftMessages.show(config: warningConfig, view: warning)
    }
    
    func showOkInfo(_ title: String, _ body: String, completion: @escaping (Bool) -> Void) {
        let info = MessageView.viewFromNib(layout: .cardView)
        info.configureTheme(.info)
        info.configureContent(title: title, body: body)
        info.button?.setTitle("Ok", for: .normal)
        info.buttonTapHandler = { _ in
            SwiftMessages.hide()
            completion(true)
        }
        var infoConfig = SwiftMessages.defaultConfig
        infoConfig.presentationStyle = .bottom
        infoConfig.duration = .forever
        SwiftMessages.show(config: infoConfig, view: info)
    }
    
    func showAlertNoInternt() {
        showError(NoInternetConnection)
    }
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }

    func hideBackWord()  {
        navigationItem.hideBackWord()
    }
        
    func popToVC(_ vc:UIViewController ,_ animated:Bool = true) {
        self.navigationController!.popToViewController(vc, animated: animated)
    }
    
    func pushNavVC(_ vc:UIViewController,_ animated:Bool = true) {
        self.navigationController?.pushViewController(vc, animated: animated)
    }
}
