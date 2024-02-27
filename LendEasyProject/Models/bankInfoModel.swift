//
//  bankInfoModel.swift
//  LendEasyProject
//
//  Created by Apple on 2023/11/1.
//

import UIKit
import SwiftyJSON
class bankInfoModel: NSObject {
    var patting : [JSON]?
    var enviouslyArr = [enviouslyArrModel]()
    init(jsondata: JSON){
        patting = jsondata["patting"].arrayValue
        let enviously = jsondata["enviously"].arrayValue
        for enviouslyDic in enviously {
            let model : enviouslyArrModel = enviouslyArrModel(jsondata: enviouslyDic)
            enviouslyArr.append(model)
        }
    }
}

class enviouslyArrModel: NSObject {
    var clamoring : String?
    var enviouslyArr = [bankEnviouslyModel]()
    init(jsondata: JSON){
        clamoring = jsondata["clamoring"].stringValue
        let enviously = jsondata["enviously"].arrayValue
        for enviouslyDic in enviously {
            let model : bankEnviouslyModel = bankEnviouslyModel(jsondata: enviouslyDic)
            enviouslyArr.append(model)
        }
    }
}

class bankEnviouslyModel: NSObject {
    var neatly : String?
    var wrinkle : String?
    var tones : String?
    var clamoring : String?
    var glanceArr = [bankGlanceModel]()
    var sooner : String?
    var sticks : String?
    var stubby : String?
    var finish : String?
    var silently : String?
    var instant : String?
    var contradicted : String?
    var flinging : String?
    init(jsondata: JSON){
        neatly = jsondata["neatly"].stringValue
        wrinkle = jsondata["wrinkle"].stringValue
        tones = jsondata["tones"].stringValue
        clamoring = jsondata["clamoring"].stringValue
        sooner = jsondata["sooner"].stringValue
        sticks = jsondata["sticks"].stringValue
        stubby = jsondata["stubby"].stringValue
        finish = jsondata["finish"].stringValue
        silently = jsondata["silently"].stringValue
        instant = jsondata["instant"].stringValue
        contradicted = jsondata["contradicted"].stringValue
        flinging = jsondata["flinging"].stringValue
        let glance = jsondata["glance"].arrayValue
        for glanceDic in glance {
            let model : bankGlanceModel = bankGlanceModel(jsondata: glanceDic)
            glanceArr.append(model)
        }
    }
}


class bankGlanceModel: NSObject {
    var sooner : String?
    var exclaim : String?
    var shoulders : String?
    init(jsondata: JSON){
        sooner = jsondata["sooner"].stringValue
        exclaim = jsondata["exclaim"].stringValue
        shoulders = jsondata["shoulders"].stringValue
    }
}

