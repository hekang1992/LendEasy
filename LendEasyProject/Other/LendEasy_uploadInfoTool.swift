//
//  LendEasy_uploadInfoTool.swift
//  LendEasyProject
//
//  Created by Apple on 2023/11/2.
//

import UIKit

class LendEasy_uploadInfoTool: NSObject {
    static func uploadHomeInfo(){
        UIDevice.current.isBatteryMonitoringEnabled = true
         var ifCharge : String = "0"
         if UIDevice.current.batteryState == UIDevice.BatteryState.charging {
             ifCharge = "1"
         }
        let timezone : String = NSTimeZone.system.abbreviation() ?? ""
        
        var paramDic = ["clutch":"ios","magnificently":UIDevice.current.systemVersion,"begged":LendEasy_User.getUserLastLoginTime(),"wishing":(Bundle.main.bundleIdentifier ?? ""),"timidly":["announced":String(format: "%.0f", UIDevice.current.batteryLevel*100),"enjoyin":ifCharge]] as [String : Any]
        
        paramDic["needed"] = ["welcome": UIDevice.current.keychainIdfv,"several":LendEasy_publicMethod.getIdfa(),"escaped":"","walker":LendEasy_publicMethod.getCurrentTime(),"beats":LendEasy_DeviceInfoTool().ca_isOpenTheProxy(),"mornin":LendEasy_DeviceInfoTool().ca_isVPNOn(),"spend":LendEasy_DeviceInfoTool().ca_isJailBreak(),"is_simulator":LendEasy_DeviceInfoTool().ca_ifSimulator(),"grimly":String(format: "%@", NSLocale.preferredLanguages.first ?? ""),"pitching":LendEasy_DeviceInfoTool().ca_getcarrierName(),"scramble":LendEasy_DeviceInfoTool().ca_getNetconnType(),"piling":timezone,"wrathfully":Int(UIDevice.current.bootTime ?? 0)] as [String : Any]
        
        paramDic["rollin"] = ["admire":"","letters":"iPhone","turnin":"","stowing":String(format: "%.0f", SCREEN_HEIGHT),"grumbling":UIDevice.current.name,"stalked":String(format: "%.0f", SCREEN_WIDTH),"trousers":UIDevice.current.modelName,"select":LendEasy_DeviceInfoTool().ca_getCurrentDeviceInch(),"inspection":UIDevice.current.systemVersion]
        
        let wifiInfo : Dictionary = LendEasy_DeviceInfoTool().ca_fetchSSIDInfo()
        paramDic["collection"] = ["wisps":["shoulders":(wifiInfo["SSID"] ?? ""),"pinching":(wifiInfo["BSSID"] ?? ""),"escaped":(wifiInfo["BSSID"] ?? ""),"alike":(wifiInfo["SSID"] ?? "")],"entire":LendEasy_publicMethod().getLocalIPAddressForCurrentWiFi() ?? "","seems": 0] as [String : Any]
        
        paramDic["uneven"] = ["obligingly" : String(LendEasy_DeviceInfoTool().ca_getAvailableDiskSize()),"choose" : String(LendEasy_DeviceInfoTool().ca_getTotalDiskSize()),"concerned" : String(LendEasy_DeviceInfoTool().ca_getTotalMemorySize()),"examination" : String(LendEasy_DeviceInfoTool().ca_getAvailableMemorySize())]
        
        print(paramDic)
        
        var jsonStr : String = ""
        do{
            let data : Data = try JSONSerialization.data(withJSONObject: paramDic)
            jsonStr = String(data: data, encoding: .utf8) ?? ""
            let encodeData = jsonStr.data(using: .utf8)
            let base64Str : String = encodeData?.base64EncodedString() ?? ""
            let params : [String:Any] = ["crows":base64Str]
            LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/after_frantically_sorrow", paramsDictionary: params, ifShowError: false, ifShowStyle: false) { model in
                
            }
          }catch{
              
          }

        
     }
}
