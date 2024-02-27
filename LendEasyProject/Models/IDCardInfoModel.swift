//
//  IDCardInfoModel.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/27.
//

import UIKit
import SwiftyJSON
class IDCardInfoModel: NSObject {
    var indoors : String?
    var tingle : String?
    var tasks : String?
    var adding : String?
    var nerve : String?
    var shoulders : String?
    var effect : String?
    var recklessly : String?
    init(jsondata: JSON){
        indoors = jsondata["indoors"].stringValue
        tingle = jsondata["tingle"].stringValue
        tasks = jsondata["tasks"].stringValue
        adding = jsondata["adding"].stringValue
        nerve = jsondata["nerve"].stringValue
        shoulders = jsondata["shoulders"].stringValue
        effect = jsondata["effect"].stringValue
        recklessly = jsondata["recklessly"].stringValue
    }
}
