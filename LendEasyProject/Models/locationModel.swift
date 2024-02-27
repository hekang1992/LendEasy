//
//  locationModel.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/30.
//

import UIKit
import SwiftyJSON
class locationModel: NSObject {
    var tearingArr = [locationModel]()
    var mouthful : String?
    var shoulders : String?
    init(jsondata: JSON){
        let tearing = jsondata["tearing"].arrayValue
        for tearingDic in tearing {
            let model : locationModel = locationModel(jsondata: tearingDic)
            tearingArr.append(model)
        }
        mouthful = jsondata["mouthful"].stringValue
        shoulders = jsondata["shoulders"].stringValue
    }
}
