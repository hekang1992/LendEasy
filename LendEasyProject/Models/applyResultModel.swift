//
//  applyResultModel.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/25.
//

import UIKit
import SwiftyJSON
class applyResultModel: NSObject {
    var recklessly : String?
    init(jsondata: JSON){
        recklessly = jsondata["recklessly"].stringValue
    }
}
