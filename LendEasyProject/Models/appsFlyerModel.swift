//
//  appsFlyerModel.swift
//  LendEasyProject
//
//  Created by Apple on 2023/11/2.
//

import UIKit
import SwiftyJSON
class appsFlyerModel: NSObject {
    var hearing : String?
    var accustomed : String?
    init(jsondata: JSON){
        hearing = jsondata["hearing"].stringValue
        accustomed = jsondata["accustomed"].stringValue
    }
}
