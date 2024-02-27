//
//  LendEasy_publicMethod.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/18.
//

import UIKit
import AdSupport
@objcMembers
class LendEasy_publicMethod: NSObject {
    static func getPublicNetWord() -> String{
        
        let hoarded = "ios"
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let eager = appVersion
        
        let vanish = UIDevice.current.modelName
        
        let squeal = UIDevice.current.keychainIdfv
        
        let ended = UIDevice.current.systemVersion
        
        let hearing = "ley"
        
        let caring = LendEasy_User.getUserSessionId()
        
        let arrived = UIDevice.current.keychainIdfv
        
        let change = obtainAnyWord()
        
        var totolWord = "hoarded=" + hoarded
        totolWord = totolWord + "&" + "eager=" + eager
        totolWord = totolWord + "&" + "vanish=" + vanish
        totolWord = totolWord  + "&" + "squeal=" + squeal
        totolWord = totolWord + "&" + "ended=" + ended
        totolWord = totolWord + "&" + "hearing=" + hearing
        totolWord = totolWord  + "&" + "caring=" + caring
        totolWord = totolWord  + "&" + "arrived=" + arrived
        totolWord = totolWord + "&" + "change=" + change
        return totolWord
    }
    
    static func obtainAnyWord() -> String {
        let wordsArray = ["Good","morning","students","teachers","very","happy","honored","opportunity","stand","share","some","things","about","ancient","civilization","history","thousand","years","During","continuously","developed","created","miracles","great","papermaking","gunpowder","promoted","spread","culture","Through","promoted","spread","invention","dissemination","knowledge","important","exchange","Kingdoms","righteousness","refused","selfish","respecting","arbiimprovementtrary","However","listening","depressed","reliance","smart","loving","impersonal","rejuvenation"]
        let random : Int = Int(arc4random_uniform(UInt32(wordsArray.count)))
        let word = wordsArray[random]
        return word
    }
    
    static func getIdfa() -> String {
        let adId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        return adId
    }
    
    static func getCurrentTime() -> String{
        let date : Date = Date()
        let time = date.timeIntervalSince1970
        let timeString = String(format: "%.0f", time*1000)
        return timeString
    }
    
    func getLocalIPAddressForCurrentWiFi() -> String? {
           var address: String?
           var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
           guard getifaddrs(&ifaddr) == 0 else {
               return nil
           }
           guard let firstAddr = ifaddr else {
               return nil
           }
           for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
               let interface = ifptr.pointee
               let addrFamily = interface.ifa_addr.pointee.sa_family
               if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                   let name = String(cString: interface.ifa_name)
                   if name == "en0" {
                       var addr = interface.ifa_addr.pointee
                       var hostName = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                       getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len), &hostName, socklen_t(hostName.count), nil, socklen_t(0), NI_NUMERICHOST)
                       address = String(cString: hostName)
                   }
               }
           }

           freeifaddrs(ifaddr)
           return address
       }
   
}
