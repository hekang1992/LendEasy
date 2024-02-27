//
//  advanceInfoModel.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/27.
//

import UIKit
import SwiftyJSON
class advanceInfoModel: NSObject {
    var misery : String?
    var reiterated : String?
    var sooner : String?
    var approvingly : String?
    init(jsondata: JSON){
        misery = jsondata["misery"].stringValue
        reiterated = jsondata["reiterated"].stringValue
        sooner = jsondata["sooner"].stringValue
        approvingly = jsondata["approvingly"].stringValue
    }
}
