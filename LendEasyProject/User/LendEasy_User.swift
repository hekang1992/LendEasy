//
//  LendEasy_User.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/20.
//

import UIKit
@objcMembers
class LendEasy_User: NSObject {
    static func saveUserSessionId(sessionId : String!){
        UserDefaults.standard.set(sessionId, forKey: "LendEasy_SessionId")
    }
    
    static func saveUserPhoneNum(phoneNumber : String!){
        UserDefaults.standard.set(phoneNumber, forKey: "LendEasy_PhoneNumber")
    }
    
    static func getUserSessionId() -> String {
        let sessionId : String? = UserDefaults.standard.value(forKey: "LendEasy_SessionId") as? String
        return sessionId ?? ""
    }
    
    static func getUserPhoneNum() -> String {
        let phoneNum : String? = UserDefaults.standard.value(forKey: "LendEasy_PhoneNumber") as? String
        return phoneNum ?? ""
    }
    
    static func saveUserLastLoginTime(time : String!){
        UserDefaults.standard.set(time, forKey: "LendEasy_LastLoginTime")
    }
    
    static func getUserLastLoginTime() -> String {
        let time : String? = UserDefaults.standard.value(forKey: "LendEasy_LastLoginTime") as? String
        return time ?? ""
    }
    
    static func saveUserLoanID(loanID : String!){
        UserDefaults.standard.set(loanID, forKey: "LendEasy_LoanId")
    }
    
    static func getUserLoanID() -> String {
        let loanID : String? = UserDefaults.standard.value(forKey: "LendEasy_LoanId") as? String
        return loanID ?? ""
    }
    
    static func checkIsLogin(topViewController : UIViewController) -> Bool {
        if getUserSessionId().count == 0 {
            let loginVC : LendEasy_LoginVC = LendEasy_LoginVC()
            let nav : LendEasy_NavitigationController = LendEasy_NavitigationController(rootViewController: loginVC)
            nav.modalPresentationStyle = .fullScreen
            topViewController.present(nav, animated: true)
            return false
        }else {
            return true
        }
    }
}
