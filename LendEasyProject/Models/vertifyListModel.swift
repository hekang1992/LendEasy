//
//  vertifyListModel.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/25.
//

import UIKit
import SwiftyJSON
class vertifyListModel: NSObject {
    var loveliest : loveliestModel?
    var handful : handfulModel?
    var whirlingArr = [whirlingModel]()
    init(jsondata: JSON){
        let loveliestDic = jsondata["loveliest"]
        loveliest = loveliestModel(jsondata: loveliestDic)
        let handfulDic = jsondata["handful"]
        handful = handfulModel(jsondata: handfulDic)
        let whirling = jsondata["whirling"].arrayValue
        for whirlingDic in whirling {
            let model : whirlingModel = whirlingModel(jsondata: whirlingDic)
            whirlingArr.append(model)
        }
    }
}

class handfulModel: NSObject {
    var efforts : String?
    init(jsondata: JSON){
        efforts = jsondata["efforts"].stringValue
    }

}

class loveliestModel: NSObject {
    var hickory : String?
    var recklessly : String?
    var clamoring : String?
    var sooner : String?
    var instant : String?
    init(jsondata: JSON){
        instant = jsondata["instant"].stringValue
        hickory = jsondata["hickory"].stringValue
        recklessly = jsondata["recklessly"].stringValue
        clamoring = jsondata["clamoring"].stringValue
        sooner = jsondata["sooner"].stringValue
    }
}

class whirlingModel: NSObject {
    var sawing : String?
    var recklessly : String?
    var disapproving : String?
    var flinging : String?
    var clamoring : String?
    var generously : String?
    var sooner : String?
    var hickory : String?
    var silently : Int?
    var instant : String?
    var nails : String?
    var sticks : String?
    init(jsondata: JSON){
        sawing = jsondata["sawing"].stringValue
        recklessly = jsondata["recklessly"].stringValue
        disapproving = jsondata["disapproving"].stringValue
        flinging = jsondata["flinging"].stringValue
        clamoring = jsondata["clamoring"].stringValue
        generously = jsondata["generously"].stringValue
        sooner = jsondata["sooner"].stringValue
        hickory = jsondata["hickory"].stringValue
        silently = jsondata["silently"].int
        instant = jsondata["instant"].stringValue
        nails = jsondata["nails"].stringValue
        sticks = jsondata["sticks"].stringValue
    }
}
