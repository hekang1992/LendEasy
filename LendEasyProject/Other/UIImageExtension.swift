//
//  UIImageExtension.swift
//  LendEasyProject
//
//  Created by Apple on 2023/9/19.
//

import UIKit

extension UIImage{
   class func imageFromColor(color: UIColor) -> UIImage{
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        return image!
    }
}
