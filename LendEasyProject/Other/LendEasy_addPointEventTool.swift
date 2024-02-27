//
//  LendEasy_addPointEventTool.swift
//  LendEasyProject
//
//  Created by Apple on 2023/11/2.
//

import UIKit

class LendEasy_addPointEventTool: NSObject {
    func addPointEvent(loanID : String,jollity : String,firstTime : String,secondTime : String){
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let params = ["gulped":loanID,"jollity":jollity,"efforts":"","unwonted":UIDevice.current.keychainIdfv,"surprised":LendEasy_publicMethod.getIdfa(),"clambered":String(appdelegate.userLocation?.coordinate.longitude ?? 0),"transport":String(appdelegate.userLocation?.coordinate.latitude ?? 0),"fling":firstTime,"peter":secondTime,"worry":LendEasy_publicMethod.obtainAnyWord()]
        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/mother_straw_cheeses", paramsDictionary: params, ifShowError: false, ifShowStyle:false) { model in
            
        }
    }
}
