//
//  UIViewExtension.swift
//  LendEasyProject
//
//  Created by Apple on 2023/11/1.
//

import Foundation
extension UIView {
func setLayerColors(_ colors:[CGColor])  {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 0, y: 1)
        self.layer.addSublayer(layer)
    }
}
