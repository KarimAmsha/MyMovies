//
//  LoadingIndicatorView.swift
//  MyMovies
//
//  Created by Karim Amsha on 17.06.2023.
//

import UIKit

/// The LoadingIndicatorView UIView
class LoadingIndicatorView: UIView {
    private let circleLayer = CAShapeLayer()
    private let colors: [UIColor] = [ColorManager.primary!, .gray]
    private let lineWidth: CGFloat = 4.0
    
    override init(frame: CGRect) {
        let adjustedFrame = CGRect(x: 0, y: 0, width: 84, height: 84)
        super.init(frame: adjustedFrame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2.0 - lineWidth
        
        let startAngle: CGFloat = -.pi / 2.0
        let endAngle: CGFloat = .pi * 2.0 - .pi / 2.0
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        circleLayer.path = circlePath.cgPath
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = colors[1].cgColor // Start with gray color
        
        layer.addSublayer(circleLayer)
        
        animate()
    }
    
    private func animate() {
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.duration = 1.5
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        strokeEndAnimation.repeatCount = .infinity
        strokeEndAnimation.isRemovedOnCompletion = false
        circleLayer.add(strokeEndAnimation, forKey: "strokeEndAnimation")
        
        let strokeColorAnimation = CAKeyframeAnimation(keyPath: "strokeColor")
        strokeColorAnimation.values = colors.map { $0.cgColor }
        strokeColorAnimation.keyTimes = [0, 0.5, 1]
        strokeColorAnimation.duration = 3.0
        strokeColorAnimation.repeatCount = .infinity
        strokeColorAnimation.isRemovedOnCompletion = false
        circleLayer.add(strokeColorAnimation, forKey: "strokeColorAnimation")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2.0 - lineWidth
        
        let startAngle: CGFloat = -.pi / 2.0
        let endAngle: CGFloat = .pi * 2.0 - .pi / 2.0
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        circleLayer.path = circlePath.cgPath
    }
    
    func startAnimation() {
        isHidden = false
        superview?.isUserInteractionEnabled = false
    }

    func stopAnimation() {
        isHidden = true
        superview?.isUserInteractionEnabled = true
    }
}
