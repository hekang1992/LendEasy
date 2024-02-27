//
//  AppDelegate.swift
//  LendEasyProject
//
//  Created by Apple on 2023/9/18.
//

import UIKit
import Alamofire
import AppTrackingTransparency
import CoreLocation
import AppsFlyerLib
@main
@objcMembers
class AppDelegate: UIResponder, UIApplicationDelegate ,CLLocationManagerDelegate{
    var window: UIWindow?
    var ifFirst : Bool = true
    var loctionTool : CLLocationManager!
    var userLocation : CLLocation?
    var hasUploadLoc : Bool = false
    var locModel : locationModel?
    var advanceModel : advanceInfoModel?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        LendEasy_RouteRegister.enroll(["LendEasy_HomeRouteRegister"])
        window?.rootViewController = LendEasy_LaunchBgViewController()
        monitorNetwork()
        return true
    }
    
    func toHomePage(){
        let userSessionId = LendEasy_User.getUserSessionId()
        if userSessionId.count != 0 {
            self.startMonitionerLocation()
        }
        let leftVC = LendEasy_LeftViewController()
        let homeVC = LendEasy_HomeViewController()
        let sliderMenu : XLSlideMenu = XLSlideMenu(rootViewController: LendEasy_NavitigationController(rootViewController: homeVC))
        sliderMenu.leftViewController = leftVC
        self.window?.rootViewController = LendEasy_NavitigationController(rootViewController: sliderMenu)
    }
    
    func getAppsFlyerInfo(){
        let params : [String:Any] = ["welcome":UIDevice.current.keychainIdfv,"trembled":LendEasy_publicMethod.obtainAnyWord(),"several":LendEasy_publicMethod.getIdfa()]
        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/delight_which_drove", paramsDictionary: params, ifShowError: false, ifShowStyle: false) { model in
            if model.neatly == 0 {
                if model.crows != nil {
                    let model :appsFlyerModel = appsFlyerModel(jsondata: model.crows!)
                    AppsFlyerLib.shared().appsFlyerDevKey = model.accustomed ?? ""
                    AppsFlyerLib.shared().appleAppID = model.hearing ?? ""
                    AppsFlyerLib.shared().start()
                }
            }
        }
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        self.initIdfa()
    }
    
    func initIdfa(){
        if #available(iOS 14, *) {
            let delayTime = DispatchTime.now() + .seconds(1)
            let delayedClosure: () -> Void = {
                ATTrackingManager.requestTrackingAuthorization { status in
                    if status == .notDetermined {
                        return
                    }
                    self.monitorNetwork()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: delayTime, execute: delayedClosure)
        } else {
        }
    }
    
    func monitorNetwork(){
        let netManager : NetworkReachabilityManager! = NetworkReachabilityManager.init()
        netManager.startListening { status in
            if status == .reachable(.ethernetOrWiFi) || status == .reachable(.cellular) {
                if self.ifFirst == true{
                    self.toHomePage()
                    self.getAppsFlyerInfo()
                    self.ifFirst = false
                }
                self.getLocInfoList()
            }
        }
    }
    
    func startMonitionerLocation(){
        self.loctionTool = CLLocationManager()
        self.loctionTool.delegate = self
        self.loctionTool.startUpdatingLocation()
        self.loctionTool.requestWhenInUseAuthorization()
        self.loctionTool.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.notDetermined {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let loginEnterTime : String = UserDefaults.standard.object(forKey: "loginEnterTime") as? String ?? ""
            let loginSuccessTime : String = UserDefaults.standard.object(forKey: "loginSuccessTime") as? String ?? ""
            if loginSuccessTime.count > 0 {
                LendEasy_addPointEventTool().addPointEvent(loanID: "", jollity: "1", firstTime: loginEnterTime, secondTime: loginSuccessTime)
                
                UserDefaults.standard.set("", forKey: "loginEnterTime")
                UserDefaults.standard.set("", forKey: "loginSuccessTime")
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TODOUPLOADIINFO"), object: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count == 0 {
            return
        }
        self.userLocation = locations.first
        if self.hasUploadLoc == false {
            if self.userLocation != nil {
                reverseGeocodeLocationWithLoc(location: self.userLocation!)
            }
        }
    }
    
    func reverseGeocodeLocationWithLoc(location : CLLocation){
        self.hasUploadLoc = true
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if placemarks?.count == 0 {
                return
            }
            let placemark = placemarks?.first
            var params = ["nerves":placemark?.administrativeArea ?? ""]
            params["whether"] = placemark?.isoCountryCode ?? ""
            params["happily"] = placemark?.country ?? ""
            params["smarted"] = placemark?.name ?? ""
            params["transport"] = String(placemark?.location?.coordinate.latitude ?? 0.0)
            params["clambered"] = String(placemark?.location?.coordinate.longitude ?? 0.0)
            params["wonderful"] = placemark?.locality ?? ""
            params["hooraying"] = LendEasy_publicMethod.obtainAnyWord()
            params["grand"] = LendEasy_publicMethod.obtainAnyWord()
            LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/grass_sitting_single", paramsDictionary: params, ifShowError: false, ifShowStyle: false) { model in
                
            }
        }
    }
    
    func addhtmlPoint(loanId : String,firstTime : String){
        LendEasy_addPointEventTool().addPointEvent(loanID: loanId, jollity: "10", firstTime: firstTime, secondTime: LendEasy_publicMethod.getCurrentTime())
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == defaultRouteSchema
            || url.scheme == httpRouteSchema
            || url.scheme  == httpsRouteSchema {
            LendEasy_Routes.global().routeURL(url)
        }
        return true
    }
    
    func getLocInfoList(){
        LendEasy_NetAPI.sharedInstance.requestGetAPI(urlPath: "/gasped_atkinss_small", paramsString: "", ifShowError: false, ifShowStyle: false) { model in
            if model.neatly == 0 {
                if model.crows != nil {
                    self.locModel = locationModel(jsondata: model.crows!)
                }
            }
        }
    }
    
//    func getAdvanceInfo(){
//        let params : [String:Any] = ["blodgett":LendEasy_publicMethod.obtainAnyWord(),"banging":LendEasy_publicMethod.obtainAnyWord()]
//        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/exclaimed_little_badly", paramsDictionary: params, ifShowError: false, ifShowStyle: false) { model in
//            if model.neatly == 0 {
//                if model.crows != nil {
//                    self.advanceModel = advanceInfoModel(jsondata: model.crows!)
//                }
//            }
//        }
//    }
}

