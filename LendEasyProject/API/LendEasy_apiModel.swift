//
//  LendEasy_apiModel.swift
//  LendEasyProject
//
//  Created by Apple on 2023/9/18.
//

import UIKit
import SwiftyJSON
class LendEasy_apiModel: NSObject{
    var neatly : Int?
    var clearing : String?
    var crows : JSON? = []
    
    init(jsondata: JSON){
        neatly = jsondata["neatly"].intValue
        clearing = jsondata["clearing"].stringValue
        crows = jsondata["crows"]
    }
}
