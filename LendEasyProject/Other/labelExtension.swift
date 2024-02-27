//
//  labelExtension.swift
//  LendEasyProject
//
//  Created by Apple on 2023/11/19.
//

import Foundation
extension UILabel {
    func labelHeight(width:CGFloat)->CGFloat{
        let dic = [NSAttributedString.Key.font : font]
        let size = CGSize(width: width, height: 0)
        let rect = text!.boundingRect(with: size, options: [.usesFontLeading,.usesLineFragmentOrigin], attributes: dic as [NSAttributedString.Key : Any], context: nil)
        return CGFloat(ceilf(Float(rect.size.height)))
    }
}
