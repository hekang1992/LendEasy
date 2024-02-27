//
//  LendEasy_LoginVC.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/3.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import SVProgressHUD
class LendEasy_LoginVC: UIViewController {
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var enterCodeView: UIView!
    @IBOutlet weak var enterCodeTextField: UITextField!
    @IBOutlet weak var sendCodeBtn: UIButton!
    @IBOutlet weak var agreementLabel: UILabel!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var scrollviewContentView: UIView!
    @IBOutlet weak var scrollviewWidth: NSLayoutConstraint!
    var seconds : NSInteger!
    var timer : Timer!
    
    var loginTime : String?
    var enterTime : String?
    
    private var telIsVaild : Bool {
        return self.phoneNumberTextField.text?.count ?? 0 >= 9
    }
    
    private var vertifyCodeIsVaild : Bool {
        return self.enterCodeTextField.text?.count ?? 0 > 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.seconds = 60
        setUpViewStyle()
        let telSignal = self.phoneNumberTextField.reactive.continuousTextValues.map { text in
            return self.telIsVaild
        }
        
        let codeSignal = self.enterCodeTextField.reactive.continuousTextValues.map { text in
            return self.vertifyCodeIsVaild
        }
        
         Signal.combineLatest(telSignal,codeSignal).map {(telIsVaild,vertifyCodeIsVaild) in
             if telIsVaild && vertifyCodeIsVaild {
                 self.nextBtn.isUserInteractionEnabled = true
                 return "login_arrow01"
             }else{
                 self.nextBtn.isUserInteractionEnabled = false
                 return "login_arrow"
             }
         }.observeValues { imageStr in
             self.nextBtn.setBackgroundImage(UIImage(named: imageStr), for: .normal)
         }
        
        self.enterTime = LendEasy_publicMethod.getCurrentTime()
        UserDefaults.standard.set(self.enterTime, forKey: "loginEnterTime")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setUpViewStyle(){
        self.phoneView.layer.cornerRadius = 25
        self.phoneView.layer.borderColor = UIColor(hex: "E2E4EA").cgColor
        self.phoneView.layer.borderWidth = 1
        
        self.enterCodeView.layer.cornerRadius = 25
        self.enterCodeView.layer.borderColor = UIColor(hex: "E2E4EA").cgColor
        self.enterCodeView.layer.borderWidth = 1
        
        let phoneNumberPlaceHolderStr = "Phone number"
        self.phoneNumberTextField.keyboardType = UIKeyboardType.phonePad
        self.phoneNumberTextField.attributedPlaceholder = phoneNumberPlaceHolderStr.attributesColor(UIColor(hex: "C5CAD5"),UIFont.systemFont(ofSize: 16))
        
        self.enterCodeTextField.keyboardType = .numberPad
        
        let enterCodePlaceHolderStr = "Enter code"
        self.enterCodeTextField.attributedPlaceholder = enterCodePlaceHolderStr.attributesColor(UIColor(hex: "C5CAD5"),UIFont.systemFont(ofSize: 16))
        let agreementStr = "By logging in or creating account, you agree to our Privacy Agreement."
        let agreementAttriStr = NSMutableAttributedString(string: agreementStr, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13)])
        let range : Range = agreementStr.range(of:"Privacy Agreement")!
        agreementAttriStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: "FF5A00"), range: NSRange(range, in: agreementStr))
        self.agreementLabel.attributedText = agreementAttriStr
        self.agreementLabel.isUserInteractionEnabled = true
        let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(toAgreementHtml))
        self.agreementLabel.addGestureRecognizer(tap)
        
        self.nextBtn.isUserInteractionEnabled = false
        
        self.scrollviewWidth.constant = SCREEN_WIDTH
        self.scrollview.contentInsetAdjustmentBehavior = .never
    }
    
    @objc func toAgreementHtml(){
        LendEasy_Routes.routeURL(URL(string: "https://www.dancepeso.com/sharp_apron_showed"))
    }
    
    
    @IBAction func sendCodeAction(_ sender: Any) {
        if self.phoneNumberTextField.text?.count == 0 {
            SVProgressHUD.showError(withStatus: "Please enter your phone number")
            return
        }
        self.sendCodeBtn.isUserInteractionEnabled = false
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeSecondsCount), userInfo: nil, repeats: true)
        
        let params : [String:Any] = ["wheels":self.phoneNumberTextField.text!,"rattle":LendEasy_publicMethod.obtainAnyWord()]
        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/pepper_course_precious",  paramsDictionary: params, ifShowError: true, ifShowStyle: true) { model in
            SVProgressHUD.showSuccess(withStatus: "Verification code sent successfully.")
        }
       
    }
    
    @objc func timeSecondsCount(){
        if self.seconds == 0 {
            self.sendCodeBtn.isUserInteractionEnabled = true
            self.timer.invalidate()
            self.timer = nil
            self.seconds = 60
            self.sendCodeBtn.setTitle("Send code", for: .normal)
            return
        }
        self.seconds = self.seconds - 1
        self.sendCodeBtn.setTitle(String(format: "%ds", self.seconds), for: .normal)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        let params : [String:Any] = ["apple":self.phoneNumberTextField.text!,"butter":LendEasy_publicMethod.obtainAnyWord(),"spread":self.enterCodeTextField.text!]
        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/sewed_quite_whole",  paramsDictionary: params, ifShowError: true, ifShowStyle: true) { model in
            if model.neatly == 0 {
                self.loginTime = LendEasy_publicMethod.getCurrentTime()
                LendEasy_User.saveUserLastLoginTime(time: self.loginTime)
                UserDefaults.standard.set(self.loginTime, forKey: "loginSuccessTime")
                
                let loginModel : LoginModel =  LoginModel(jsondata: model.crows!)
                LendEasy_User.saveUserSessionId(sessionId: loginModel.caring)
                LendEasy_User.saveUserPhoneNum(phoneNumber: loginModel.apple)
                self.dismiss(animated: true)
                
                let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.startMonitionerLocation()
                
                SVProgressHUD.showSuccess(withStatus: "Login successful.")
            }
         
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
