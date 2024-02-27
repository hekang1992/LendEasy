//
//  LendEasy_VertifyProcessViewController.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/25.
//

import UIKit
@objcMembers
class LendEasy_VertifyProcessViewController: UIViewController {
    @IBOutlet weak var topConstrat: NSLayoutConstraint!
    @IBOutlet weak var vertifyTitleLabel: UILabel!
    @IBOutlet weak var vertifySubtitleLabel: UILabel!
    @IBOutlet weak var operationBtn: UIButton!
    @IBOutlet weak var vertifyStepIcon: UIImageView!
    @IBOutlet weak var vertifyStepLabel: UILabel!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var circleProcessIcon: UIImageView!
    @IBOutlet weak var checkProcessIntroBtn: UIButton!
    @IBOutlet weak var progessImageView: UIImageView!
    @IBOutlet weak var bottomMarginContant: NSLayoutConstraint!
    @IBOutlet weak var firstContant: NSLayoutConstraint!
    @IBOutlet weak var secondContant: NSLayoutConstraint!
    
    var loadId : String!
    var timer : Timer!
    var vertifyModel : vertifyListModel?
    var model : identifyModel!
    var enterTime : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.topConstrat.constant = CGFloat(k_StatusBarHeight + 15)
        
        self.operationBtn.layer.cornerRadius = 25
        self.operationBtn.clipsToBounds = true
        
        self.stateView.layer.cornerRadius = 12
        
        self.operationBtn.isEnabled = false
        self.operationBtn.isUserInteractionEnabled = false
        
        self.checkProcessIntroBtn.isUserInteractionEnabled = false
        
        if SCREEN_HEIGHT <= 812 {
            self.bottomMarginContant.constant = 10
            self.firstContant.constant = 10
            self.secondContant.constant = 50
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        flipImage()
        getVertifyStepList()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeStateAction), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
        
    }
    
    func flipImage(){
        let momAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        momAnimation.fromValue=NSNumber(value:0)
        momAnimation.toValue=NSNumber(value:Double.pi*2)
        momAnimation.duration = 1
        momAnimation.repeatCount = 1
        circleProcessIcon.layer.add(momAnimation, forKey:"centerLayer")
    }
    
    @objc func changeStateAction(){
        flipImage()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getIDList(){
        let paramStr : String! = "worried=" + LendEasy_publicMethod.obtainAnyWord() + "&" + "stories=" + self.loadId
        LendEasy_NetAPI.sharedInstance.requestGetAPI(urlPath: "/doors_little_mamsie", paramsString: paramStr, ifShowError: true, ifShowStyle: true) { model in
            if model.neatly == 0 {
                self.model = identifyModel(jsondata: model.crows!)
                if self.model.overcome?.silently != 1 {
                    let vc : LendEasy_ChooseIDViewController = LendEasy_ChooseIDViewController()
                    vc.loadId = self.loadId
                    vc.titleStr = self.vertifyModel?.loveliest?.clamoring ?? "Verify Identity"
                    vc.model = self.model
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    let vertifyIdentifyVC : LendEasy_VertifyIdentifyViewController = LendEasy_VertifyIdentifyViewController()
                    vertifyIdentifyVC.titleStr = self.vertifyModel?.loveliest?.clamoring ?? "Verify Identity"
                    vertifyIdentifyVC.loadId = self.loadId
                    vertifyIdentifyVC.model = self.model
                    self.navigationController?.pushViewController(vertifyIdentifyVC, animated: true)
                }
            }
        }
    }
    
    func getVertifyStepList(){
        let params : [String:String] = ["stories":self.loadId!,"build":LendEasy_publicMethod.obtainAnyWord(),"fondly":LendEasy_publicMethod.obtainAnyWord()]
        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/least_tearing_called",  paramsDictionary: params, ifShowError: true, ifShowStyle: false) { model in
            self.timer.invalidate()
            self.operationBtn.isEnabled = true
            self.operationBtn.isUserInteractionEnabled = true
            self.checkProcessIntroBtn.isUserInteractionEnabled = true
            self.stateLabel.text = "To be completed"
            if model.neatly == 0 {
                if model.crows != nil {
                    self.vertifyModel = vertifyListModel(jsondata: model.crows!)
                    if self.vertifyModel?.loveliest?.hickory?.count != 0 {
                        self.vertifyTitleLabel.text = self.vertifyModel?.loveliest?.clamoring ?? ""
                        self.vertifyStepLabel.text = self.vertifyModel?.loveliest?.clamoring ?? ""
                        self.vertifySubtitleLabel.text = self.vertifyModel?.loveliest?.instant ?? ""
                        if self.vertifyModel?.loveliest?.hickory == "ba" {  //public
                            self.progessImageView.image = UIImage(named: "vertify_icon01")
                            self.vertifyStepIcon.image = UIImage(named: "item01")
//                            self.vertifySubtitleLabel.text = "Helps to quickly pass audits"
                        }else if self.vertifyModel?.loveliest?.hickory == "cs" { //personal
                            self.progessImageView.image = UIImage(named: "vertify_icon02")
                            self.vertifyStepIcon.image = UIImage(named: "item02")
//                            self.vertifySubtitleLabel.text = "Settlement of collection amount"
                        }else if self.vertifyModel?.loveliest?.hickory == "rt" {  //work
                            self.progessImageView.image = UIImage(named: "vertify_icon03")
                            self.vertifyStepIcon.image = UIImage(named: "item03")
//                            self.vertifySubtitleLabel.text = "Helps to quickly pass audits"
                        }else if self.vertifyModel?.loveliest?.hickory == "io" {  //ext
                            self.progessImageView.image = UIImage(named: "vertify_icon04")
                            self.vertifyStepIcon.image = UIImage(named: "item04")
//                            self.vertifySubtitleLabel.text = "Just for smooth communication"
                        }else if self.vertifyModel?.loveliest?.hickory == "po" {  //bank
                            self.progessImageView.image = UIImage(named: "vertify_icon05")
                            self.vertifyStepIcon.image = UIImage(named: "item04")
//                            self.vertifySubtitleLabel.text = "Just for smooth communication"
                            self.stateLabel.text = "Completed"
                            self.operationBtn.setBackgroundImage(UIImage(named: "continueBtnBg"), for: .normal)
                        }
                    }else{
//                        let arrcount = self.vertifyModel?.whirlingArr.count
//                        let model : whirlingModel = (self.vertifyModel?.whirlingArr[arrcount! - 2])!
//                        self.vertifyTitleLabel.text = model.clamoring ?? ""
//                        self.vertifyStepLabel.text = model.clamoring ?? ""
                        
                        self.progessImageView.image = UIImage(named: "vertify_icon05")
                        self.vertifyStepIcon.image = UIImage(named: "item04")
                        self.vertifyTitleLabel.text = "Certification completed"
                        self.vertifyStepLabel.text = "Certification completed"
                        self.vertifySubtitleLabel.text = "Click Continue to apply for a loan directly"
                        self.stateLabel.text = "Completed"
                        self.operationBtn.setBackgroundImage(UIImage(named: "continueBtnBg"), for: .normal)
                    }
                }
            }
            
        }
    }
    
    
    @IBAction func operationAction(_ sender: Any) {
        if self.vertifyModel?.loveliest?.hickory?.count != 0 {
            if self.vertifyModel?.loveliest?.hickory == "ba" {  //public
                getIDList()
            }else if self.vertifyModel?.loveliest?.hickory == "cs" { //personal
                let vc : LendEasy_FillBasicInfoViewController = LendEasy_FillBasicInfoViewController()
                vc.loadId = self.loadId
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.vertifyModel?.loveliest?.hickory == "rt" {  //work
                let vc : LendEasy_workInfomationViewController = LendEasy_workInfomationViewController()
                vc.loadId = self.loadId
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.vertifyModel?.loveliest?.hickory == "io" {  //ext
                let vc : LendEasy_ContactViewController = LendEasy_ContactViewController()
                vc.loadId = self.loadId
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.vertifyModel?.loveliest?.hickory == "po" {  //bank
                let viewArr = Bundle.main.loadNibNamed("LendEasy_centerAlertView", owner: nil)
                let centerAlertView : LendEasy_centerAlertView = viewArr![0] as! LendEasy_centerAlertView
                self.view.addSubview(centerAlertView)
                centerAlertView.mas_makeConstraints { make in
                    make?.left.offset()(0)
                    make?.right.offset()(0)
                    make?.bottom.offset()(0)
                    make?.top.offset()(0)
                 }
                
                centerAlertView.cancelBlock = {
                    
                }
                
                centerAlertView.operationBlock = {
                    let vc : LendEasy_bindBankCardViewController = LendEasy_bindBankCardViewController()
                    vc.loadId = self.loadId
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.fillBankInfoSuccess = {
                        self.navigationController?.popViewController(animated: true)
                        
                        self.enterTime = LendEasy_publicMethod.getCurrentTime()
                        let params : [String:String] = ["seizing":self.vertifyModel?.handful?.efforts ?? "","piped":LendEasy_publicMethod.obtainAnyWord(),"watch":LendEasy_publicMethod.obtainAnyWord(),"keeping":LendEasy_publicMethod.obtainAnyWord(),"folding":LendEasy_publicMethod.obtainAnyWord()]
                        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/border_splash_daughter", paramsDictionary: params, ifShowError:true, ifShowStyle: true) { model in
                            if model.neatly == 0 {
                                self.navigationController?.popViewController(animated: false)
                                let model : applyResultModel = applyResultModel(jsondata: model.crows!)
                                if model.recklessly?.count ?? 0 > 0 {
                                    LendEasy_addPointEventTool().addPointEvent(loanID: self.loadId ?? "", jollity: "9", firstTime: self.enterTime ?? "", secondTime: LendEasy_publicMethod.getCurrentTime())
                                    
                                    LendEasy_Routes.routeURL(URL(string: model.recklessly!))
                                }
                            }
                        }
                    }
                }
            }
        }else{
            self.enterTime = LendEasy_publicMethod.getCurrentTime()
            let params : [String:String] = ["seizing":self.vertifyModel?.handful?.efforts ?? "","piped":LendEasy_publicMethod.obtainAnyWord(),"watch":LendEasy_publicMethod.obtainAnyWord(),"keeping":LendEasy_publicMethod.obtainAnyWord(),"folding":LendEasy_publicMethod.obtainAnyWord()]
            LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/border_splash_daughter", paramsDictionary: params, ifShowError:true, ifShowStyle: true) { model in
                if model.neatly == 0 {
                    self.navigationController?.popViewController(animated: false)
                    let model : applyResultModel = applyResultModel(jsondata: model.crows!)
                    if model.recklessly?.count ?? 0 > 0 {
                        LendEasy_addPointEventTool().addPointEvent(loanID: self.loadId ?? "", jollity: "9", firstTime: self.enterTime ?? "", secondTime: LendEasy_publicMethod.getCurrentTime())
                        
                        LendEasy_Routes.routeURL(URL(string: model.recklessly!))
                    }
                }
            }
            
        }
    }
    
    @IBAction func checkProcessIntroAction(_ sender: Any) {
        let viewArr = Bundle.main.loadNibNamed("LendEasy_bottomVertifyAlertView", owner: nil)
        let bottomAlertView : LendEasy_bottomVertifyAlertView = viewArr![0] as! LendEasy_bottomVertifyAlertView
        bottomAlertView.model = self.vertifyModel!
        self.view.addSubview(bottomAlertView)
        bottomAlertView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.bottom.offset()(0)
            make?.top.offset()(0)
        }
        
        bottomAlertView.checkItem01Block = { model in
            self.getIDList()
        }
        
        bottomAlertView.checkItem02Block = { model in
            let vc : LendEasy_FillBasicInfoViewController = LendEasy_FillBasicInfoViewController()
            vc.loadId = self.loadId
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        bottomAlertView.checkItem03Block = { model in
            let vc : LendEasy_workInfomationViewController = LendEasy_workInfomationViewController()
            vc.loadId = self.loadId
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        bottomAlertView.checkItem04Block = { model in
            let vc : LendEasy_ContactViewController = LendEasy_ContactViewController()
            vc.loadId = self.loadId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
