//
//  identifyModel.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/26.
//

import UIKit
import SwiftyJSON
class identifyModel: NSObject {
    var oozing : [JSON]?
    var overcome : overcomeModel?
    var sooner : String?
    var recklessly : String?
    var bumped : Int?
    init(jsondata: JSON){
        oozing = jsondata["oozing"].arrayValue
        let overcomeDic = jsondata["overcome"]
        overcome = overcomeModel(jsondata: overcomeDic)
        sooner = jsondata["sooner"].stringValue
        recklessly = jsondata["recklessly"].stringValue
        bumped = jsondata["bumped"].int
    }
}


class overcomeModel: NSObject {
    var recklessly : String?
    var silently : Int?
    var rained : String?
    var towel : towelModel?
    init(jsondata: JSON){
        recklessly = jsondata["recklessly"].string
        rained = jsondata["rained"].string
        silently = jsondata["silently"].int
        let towelDic = jsondata["towel"]
        towel = towelModel(jsondata: towelDic)
    }
}

class towelModel: NSObject {
    var shoulders : String?
    var effect : String?
    var adding : String?
    init(jsondata: JSON){
        shoulders = jsondata["shoulders"].string
        effect = jsondata["effect"].string
        adding = jsondata["adding"].string
    }
}

