//
//  LendEasy_NetAPI.swift
//  LendEasyProject
//
//  Created by Apple on 2023/9/18.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
class LendEasy_NetAPI: NSObject {
    static let sharedInstance = LendEasy_NetAPI()
    func requestPostAPI(urlPath : String, paramsDictionary : [String:Any]?, ifShowError : Bool, ifShowStyle : Bool,block : @escaping (LendEasy_apiModel) -> Void){
        let manager : NetworkReachabilityManager! = NetworkReachabilityManager.init()
        manager.startListening { status in
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable{
                print("Please check network permissions")
                return
            }
        }
        
        if ifShowStyle == true {
            SVProgressHUD.show(withStatus: nil)
        }
        
        AF.session.configuration.timeoutIntervalForRequest = 18
        let headers: HTTPHeaders = [
            "Accept" : "application/json;",
            "Connection" : "keep-alive",
            "Content-Type" : "application/x-www-form-urlencoded;text/json;text/javascript;text/html;text/plain;multipart/form-data"
        ]
       
        var wholeUrlPath = "https://www.dancepeso.com/ez/" + urlPath + "?" + LendEasy_publicMethod.getPublicNetWord()
        wholeUrlPath = wholeUrlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        AF.request(wholeUrlPath, method: HTTPMethod.post,parameters:paramsDictionary,headers: headers).responseDecodable {(response:DataResponse<JSON, AFError>) in
            
            if ifShowStyle == true {
                SVProgressHUD.dismiss()
            }
            
            if response.data == nil {
                print("no data")
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: response.data!,options:[.mutableContainers,.mutableLeaves,.fragmentsAllowed])
            let jsonDic = JSON.init(json as Any)
            print("data ----- \n\(String(describing: jsonDic))")
            
            let model =  LendEasy_apiModel(jsondata: jsonDic)
            if model.neatly == 0 {
                block(model)
            }else{
                if model.neatly == -2 {
                    if LendEasy_User.checkIsLogin(topViewController: UIViewController.top()) == false {
                        return
                    }
                }else {
                    if ifShowError == true {
                        SVProgressHUD.showError(withStatus: model.clearing)
                    }
                }
                block(model)
           }
        }
    }
    
    func requestGetAPI(urlPath : String, paramsString : String?, ifShowError : Bool, ifShowStyle : Bool,block : @escaping (LendEasy_apiModel) -> Void){
        let manager : NetworkReachabilityManager! = NetworkReachabilityManager.init()
        manager.startListening { status in
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable{
                print("Please check network permissions")
                return
            }
        }
        
        if ifShowStyle == true {
            SVProgressHUD.show(withStatus: nil)
        }
        
        AF.session.configuration.timeoutIntervalForRequest = 18
        let headers: HTTPHeaders = [
            "Accept" : "application/json;",
            "Connection" : "keep-alive",
            "Content-Type" : "application/x-www-form-urlencoded;text/json;text/javascript;text/html;text/plain;multipart/form-data"
        ]
        
        var wholeUrlPath = "https://www.dancepeso.com/ez" + urlPath + "?" + LendEasy_publicMethod.getPublicNetWord()
        if paramsString!.count > 0 {
            wholeUrlPath = wholeUrlPath + "&" + paramsString!
        }
        wholeUrlPath = wholeUrlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        AF.request(wholeUrlPath, method:HTTPMethod.get, parameters:nil, headers:headers).responseDecodable {(response:DataResponse<JSON, AFError>) in
            
            if ifShowStyle == true {
                SVProgressHUD.dismiss()
            }
            
            if response.data == nil {
                print("no data")
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: response.data!,options:[.mutableContainers,.mutableLeaves,.fragmentsAllowed])
            let jsonDic = JSON.init(json as Any)
            print("data ----- \n\(String(describing: jsonDic))")
            
            let model =  LendEasy_apiModel(jsondata: jsonDic)
            
            if model.neatly == 0 {
                block(model)
            }else{
                if model.neatly == -2 {
                    if LendEasy_User.checkIsLogin(topViewController: UIViewController.top()) == false {
                        return
                    }
                }else {
                    if ifShowError == true {
                        SVProgressHUD.showError(withStatus: model.clearing)
                    }
                }
                block(model)
            }
        }
    }
    
    func uploadImageAPI(urlPath : String, paramsDic : [String:Any]?, image : UIImage, imageName : String, ifShowError : Bool, ifShowStyle : Bool, block :@escaping (LendEasy_apiModel) -> Void){
        let manager : NetworkReachabilityManager! = NetworkReachabilityManager.init()
        manager.startListening { status in
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable{
                SVProgressHUD.showError(withStatus: "Please check network permissions")
                return
            }
        }
        
        if ifShowStyle == true {
            SVProgressHUD.show(withStatus: nil)
        }
        
        AF.session.configuration.timeoutIntervalForRequest = 18
        let headers: HTTPHeaders = [
            "Accept" : "application/json;",
            "Connection" : "keep-alive",
            "Content-Type" : "application/x-www-form-urlencoded;text/json;text/javascript;text/html;text/plain;multipart/form-data",
        ]
        
        var wholeUrlPath = "https://www.dancepeso.com/ez" + urlPath + "?" + LendEasy_publicMethod.getPublicNetWord()
        wholeUrlPath = wholeUrlPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        AF.upload(multipartFormData: { multipartFormData in
            let data : Data = image.jpegData(compressionQuality: 0.2) ?? Data()
            multipartFormData.append(data, withName: imageName,fileName: imageName + ".png",mimeType: "image/png")
            for param in paramsDic! {
                let value : String! = param.value as? String
                multipartFormData.append((value.data(using: .utf8))!, withName: param.key)
            }
        }, to: wholeUrlPath, method: .post,headers: headers).uploadProgress { progress in
            print("upload success")
        }.responseDecodable {(response:DataResponse<JSON, AFError>) in
            
            if ifShowStyle == true {
                SVProgressHUD.dismiss()
            }
            
            if response.error != nil {
                print("error --- \(response.error.debugDescription)")
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: response.data!,options:[.mutableContainers,.mutableLeaves,.fragmentsAllowed])
            let jsonDic = JSON.init(json as Any)
            print("data ----- \n\(String(describing: jsonDic))")
            
            let model =  LendEasy_apiModel(jsondata: jsonDic)
            if model.neatly == 0 {
                block(model)
            }else{
                if model.neatly == -2 {
                    if LendEasy_User.checkIsLogin(topViewController: UIViewController.top()) == false {
                        return
                    }
                }else {
                    if ifShowError == true {
                        SVProgressHUD.showError(withStatus:model.clearing)
                    }
                }
                block(model)
            }
        }
    }
    
    func yb_requestUrlArr(block :@escaping (Data?) -> Void){
        let manager : NetworkReachabilityManager! = NetworkReachabilityManager.init()
        manager.startListening { status in
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable{
                SVProgressHUD.showError(withStatus: "Please check network permissions")
                return
            }
        }
        
        SVProgressHUD.show(withStatus: nil)
        AF.session.configuration.timeoutIntervalForRequest = 18
        
        let headers: HTTPHeaders = [
            "Accept" : "application/json;",
            "Connection" : "keep-alive",
            "Content-Type" : "application/x-www-form-urlencoded;text/json;text/javascript;text/html;text/plain;multipart/form-data;application/json",
        ]
        
        let url = "https://id-cash-ace-prod-files.oss-ap-southeast-5.aliyuncs.com/tds/tds.txt"
        AF.request(url, method: HTTPMethod.get,parameters:nil,headers: headers).response { (response:DataResponse) in
            SVProgressHUD.dismiss()
            block(response.data)
        }
     }
}
