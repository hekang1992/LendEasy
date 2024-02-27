//
//  LoginModel.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/20.
//

import UIKit
import SwiftyJSON

class LoginModel: NSObject {
    var uid : String?
    var caring : String?
    var apple : String?
    
    init(jsondata: JSON){
        uid = jsondata["uid"].stringValue
        caring = jsondata["caring"].stringValue
        apple = jsondata["apple"].stringValue
    }
}
