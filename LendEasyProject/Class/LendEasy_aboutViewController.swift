//
//  LendEasy_aboutViewController.swift
//  LendEasyProject
//
//  Created by Apple on 2023/11/2.
//

import UIKit
import SVProgressHUD
class LendEasy_aboutViewController: UIViewController {
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var deleteAccountBtn: UIButton!
    @IBOutlet weak var logoIcon: UIImageView!
    var deleteAccountBlock:((String)->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        self.versionLabel.text = "V" + version!
        
        self.deleteAccountBtn.layer.cornerRadius = 8.0
        
        let webStr = "Product Website:www.dancepeso.com"
        let webAttriStr:NSMutableAttributedString = NSMutableAttributedString(string: webStr)
        let range = webAttriStr.string.range(of: "www.dancepeso.com")
        webAttriStr.addAttributes([.foregroundColor: UIColor(hex: "7d99d1")], range:NSRange(range!, in: webStr))
        self.websiteLabel.attributedText = webAttriStr
        
        self.logoIcon.layer.cornerRadius = 10
        
        self.websiteLabel.isUserInteractionEnabled = true
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(webAction))
        self.websiteLabel.addGestureRecognizer(tap)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    @objc func webAction(){
        LendEasy_Routes.openURL("https://www.dancepeso.com/")
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func deleteAccountAction(_ sender: Any) {
        let paramStr : String! = "hines=" + LendEasy_publicMethod.obtainAnyWord()
        LendEasy_NetAPI.sharedInstance.requestGetAPI(urlPath: "/there_hell_nik", paramsString: paramStr, ifShowError: true, ifShowStyle: true) { model in
            if model.neatly == 0 {
                LendEasy_User.saveUserPhoneNum(phoneNumber: "")
                LendEasy_User.saveUserSessionId(sessionId: "")
                self.deleteAccountBlock?(model.clearing ?? "")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LOGOUT"), object: nil)
            }
        }
    }
}
