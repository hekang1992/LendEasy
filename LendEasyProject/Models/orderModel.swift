//
//  orderModel.swift
//  LendEasyProject
//
//  Created by Apple on 2023/11/7.
//

import UIKit
import SwiftyJSON

class orderModel: NSObject {
    var orderTearingArr = [orderTearingModel]()
    init(jsondata: JSON){
        let tearing = jsondata["tearing"].arrayValue
        for tearingDic in tearing {
            let model : orderTearingModel = orderTearingModel(jsondata: tearingDic)
            orderTearingArr.append(model)
        }
    }
}

class orderTearingModel: NSObject {
    var hoping : String?
    var matters : String?
    var suddenly : String?
    var jerks : String?
    var clumsy : String?
    var efforts : String?
    var untying : String?
    var goody : String?
    var stifled : String?
    var clattered : String?
    var hallooing : String?
    var horsie : String?
    var ravellings : String?
    var remainder : String?
    var whooping : String?
    var harness : String?
    var upset : String?
    var wedding : String?
    var succeeding : String?
    var shout : String?
    var gulped : String?
    var bubbling : String?
    var smoking : String?
    var snippings : String?
    init(jsondata: JSON){
        hoping = jsondata["hoping"].stringValue
        matters = jsondata["matters"].stringValue
        suddenly = jsondata["suddenly"].stringValue
        jerks = jsondata["jerks"].stringValue
        clumsy = jsondata["clumsy"].stringValue
        efforts = jsondata["efforts"].stringValue
        untying = jsondata["untying"].stringValue
        goody = jsondata["goody"].stringValue
        stifled = jsondata["stifled"].stringValue
        clattered = jsondata["clattered"].stringValue
        hallooing = jsondata["hallooing"].stringValue
        horsie = jsondata["horsie"].stringValue
        ravellings = jsondata["ravellings"].stringValue
        remainder = jsondata["remainder"].stringValue
        whooping = jsondata["whooping"].stringValue
        harness = jsondata["harness"].stringValue
        upset = jsondata["upset"].stringValue
        wedding = jsondata["wedding"].stringValue
        succeeding = jsondata["succeeding"].stringValue
        shout = jsondata["shout"].stringValue
        gulped = jsondata["gulped"].stringValue
        bubbling = jsondata["bubbling"].stringValue
        smoking = jsondata["smoking"].stringValue
        snippings = jsondata["snippings"].stringValue
    }
}
