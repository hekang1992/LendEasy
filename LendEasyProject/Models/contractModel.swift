//
//  contractModel.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/31.
//

import UIKit
import SwiftyJSON
class contractModel: NSObject {
    var tearingArr = [tearingModel]()
    init(jsondata: JSON){
        let tearing = jsondata["tearing"].arrayValue
        for tearingDic in tearing {
            let model : tearingModel = tearingModel(jsondata: tearingDic)
            tearingArr.append(model)
        }
    }
}

class tearingModel: NSObject {
    var bobbing : String?
    var brisk : String?
    var shoulders : String?
    var tossed : String?
    var hardest : String?
    var nimikArr = [nimikModel]()
    init(jsondata: JSON){
        bobbing = jsondata["bobbing"].stringValue
        brisk = jsondata["brisk"].stringValue
        shoulders = jsondata["shoulders"].stringValue
        tossed = jsondata["tossed"].stringValue
        hardest = jsondata["hardest"].stringValue
        let nimik = jsondata["nimik"].arrayValue
        for nimikDic in nimik {
            let model : nimikModel = nimikModel(jsondata: nimikDic)
            nimikArr.append(model)
        }
    }
}


class nimikModel: NSObject {
    var shoulders : String?
    var sooner : String?
    init(jsondata: JSON){
        shoulders = jsondata["shoulders"].stringValue
        sooner = jsondata["sooner"].stringValue
    }
}
