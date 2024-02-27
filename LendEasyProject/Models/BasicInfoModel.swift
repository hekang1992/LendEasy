//
//  BasicInfoModel.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/30.
//

import UIKit
import SwiftyJSON
class BasicInfoModel: NSObject {
    var enviouslyArr = [enviouslyModel]()
    init(jsondata: JSON){
        let enviously = jsondata["enviously"].arrayValue
        for enviouslyDic in enviously {
            let model : enviouslyModel = enviouslyModel(jsondata: enviouslyDic)
            enviouslyArr.append(model)
        }
    }
}


class enviouslyModel: NSObject {
    var neatly : String?
    var silently : String?
    var sooner : String?
    var tones : String?
    var sticks : String?
    var mouthful : String?
    var flinging : String?
    var shoulder : String?
    var contradicted : String?
    var wrinkle : String?
    var finish : String?
    var instant : String?
    var clamoring : String?
    var glanceArr = [glanceModel]()
    init(jsondata: JSON){
        neatly = jsondata["neatly"].stringValue
        silently = jsondata["silently"].stringValue
        tones = jsondata["tones"].stringValue
        sooner = jsondata["sooner"].stringValue
        sticks = jsondata["sticks"].stringValue
        mouthful = jsondata["mouthful"].stringValue
        flinging = jsondata["flinging"].stringValue
        shoulder = jsondata["shoulder"].stringValue
        contradicted = jsondata["contradicted"].stringValue
        wrinkle = jsondata["wrinkle"].stringValue
        finish = jsondata["finish"].stringValue
        instant = jsondata["instant"].stringValue
        clamoring = jsondata["clamoring"].stringValue
        let glance = jsondata["glance"].arrayValue
        for glanceDic in glance {
            let model : glanceModel = glanceModel(jsondata: glanceDic)
            glanceArr.append(model)
        }
    }

}

class glanceModel: NSObject {
    var shoulders : String!
    var sooner : String!
    var glanceArr = [glanceModel]()
    init(jsondata: JSON){
        shoulders = jsondata["shoulders"].stringValue
        sooner = jsondata["sooner"].stringValue
        let glance = jsondata["glance"].arrayValue
        for glanceDic in glance {
            let model : glanceModel = glanceModel(jsondata: glanceDic)
            glanceArr.append(model)
        }
    }
}
