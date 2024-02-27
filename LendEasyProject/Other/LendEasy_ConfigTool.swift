//
//  CAConfigTool.swift
//  cashACEProject
//
//  Created by Apple on 2023/6/12.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let  k_StatusBarHeight = (SCREEN_HEIGHT >= 812.0 ? 44 : 20)

let k_NavigationBarHeight = (SCREEN_HEIGHT >= 812.0 ? 88 : 64)

let k_SafeAreaBottomHeight = (SCREEN_HEIGHT >= 812.0 ? 34 : 0)

func width(a : CGFloat) -> CGFloat{
    return (SCREEN_WIDTH/375)*a
}
