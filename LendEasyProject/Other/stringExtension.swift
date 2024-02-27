//
//  File.swift
//  cashACEProject
//
//  Created by Apple on 2023/6/14.
//

import Foundation
import UIKit

extension String {
    func attributesColor(_ color: UIColor, _ font: UIFont) -> NSAttributedString {
        let attri = NSMutableAttributedString(string: self)
        attri.addAttributes([.foregroundColor: color], range: NSRange(location: 0, length: self.count))
        attri.addAttributes([.font: font], range: NSRange(location: 0, length: self.count))
        return attri
    }
 
}
