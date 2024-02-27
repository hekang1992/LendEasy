//
//  LendEasy_bindBankCardViewController.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/31.
//

import UIKit

class LendEasy_bindBankCardViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var contentWidthConstant: NSLayoutConstraint!
    @IBOutlet weak var contentHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var bindBtn: UIButton!
    var chooseTypeView : LendEasy_workInfoItemView!
    var bankModel : bankInfoModel?
    var bankArrModel : enviouslyArrModel?
    var walletArrModel : enviouslyArrModel?
    var currentArrModel : enviouslyArrModel?
    var style : Int = 0 //1: bank 0: wallet
    var locModel : locationModel?
    var locArr = [String]()
    var fillInfoTFArr = [UITextField]()
    var basicFillInfoArr : [String : String] = [:]
    var enterTime : String?
    var loadId : String!
    var fillBankInfoSuccess:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterTime = LendEasy_publicMethod.getCurrentTime()

        self.setUpStyleView()
        
        self.getBankFillInfoList()
    }

    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpStyleView(){
        bindBtn.layer.cornerRadius = 25
        self.contentWidthConstant.constant = SCREEN_WIDTH
        
        self.tipView.layer.cornerRadius = 9.0
    }
    
    @objc func chooseTypeAction(){
        let enumAlertView : LendEasy_EnumAlertView = LendEasy_EnumAlertView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), style: CACommonAlertStyle, itemArr: ["E-wallat","Bank"])
        enumAlertView.alertTitleLabel.text = "Card Type"
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.endEditing(true)
        appdelegate.window?.addSubview(enumAlertView)
        enumAlertView.confirmBlock = { index in
            if index == self.style {
                return
            }
            self.style = index
            self.setUpFillInfoForm()
        }
    }
    
    func setUpFillInfoForm(){
        self.basicFillInfoArr = [:]
        self.fillInfoTFArr = [UITextField]()
        for subview in self.scrollContentView.subviews {
            subview.removeFromSuperview()
        }
        
        //choose fill type
        let viewArr = Bundle.main.loadNibNamed("LendEasy_workInfoItemView", owner: nil)
        self.chooseTypeView = (viewArr![0] as! LendEasy_workInfoItemView)
        self.scrollContentView.addSubview(self.chooseTypeView)
        if self.style == 0 {
            self.chooseTypeView.fillTextField.text = "E-wallat"
        }else{
            self.chooseTypeView.fillTextField.text = "Bank"
        }
        self.chooseTypeView.fillTitleLabel.text = "Select Card Type"
        self.chooseTypeView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.top.offset()(0)
            make?.height.equalTo()(105)
            make?.right.offset()(0)
        }
        self.chooseTypeView.downArrowIcon.isHidden = false
        self.chooseTypeView.fillTextField.isUserInteractionEnabled = false
        self.chooseTypeView.fillView.isUserInteractionEnabled = true

        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseTypeAction))
        self.chooseTypeView.fillView.addGestureRecognizer(tap)
        
        for model : enviouslyArrModel in (self.bankModel?.enviouslyArr)! {
            if model.clamoring == "E-wallet" {
                self.walletArrModel = model
            }else{
                self.bankArrModel = model
            }
        }
        
        if style == 0{
            self.currentArrModel = walletArrModel
        }else{
            self.currentArrModel = bankArrModel
        }
        
        for enviouslymodel : bankEnviouslyModel in (self.currentArrModel?.enviouslyArr)! {
            self.basicFillInfoArr[enviouslymodel.neatly!] = enviouslymodel.sooner
        }
        
        if self.currentArrModel?.enviouslyArr.count ?? 0 > 0 {
            for i in 0...(self.currentArrModel?.enviouslyArr.count)! - 1 {
                let viewArr = Bundle.main.loadNibNamed("LendEasy_workInfoItemView", owner: nil)
                let workInfoItemView : LendEasy_workInfoItemView = viewArr![0] as! LendEasy_workInfoItemView
                self.scrollContentView.addSubview(workInfoItemView)
                workInfoItemView.mas_makeConstraints { make in
                    make?.left.offset()(0)
                    make?.top.offset()(105 + CGFloat(105*i))
                    make?.height.equalTo()(105)
                    make?.right.offset()(0)
                }

                let currentModel : bankEnviouslyModel = (self.currentArrModel?.enviouslyArr[i])!
                workInfoItemView.fillTitleLabel.text = currentModel.clamoring
                workInfoItemView.fillTextField.placeholder = currentModel.instant
                workInfoItemView.fillTextField.text = currentModel.tones
                workInfoItemView.fillView.tag = i
                if currentModel.finish == "1" || currentModel.finish == "3" {
                    workInfoItemView.downArrowIcon.isHidden = false
                    workInfoItemView.fillTextField.isUserInteractionEnabled = false
                    workInfoItemView.fillView.isUserInteractionEnabled = true

                    let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(itemClick))
                    workInfoItemView.fillView.addGestureRecognizer(tap)

                }else{
                    workInfoItemView.downArrowIcon.isHidden = true
                    workInfoItemView.fillTextField.isUserInteractionEnabled = true
                    workInfoItemView.fillTextFieldTrailConstant.constant = 0

                }

                self.fillInfoTFArr.append(workInfoItemView.fillTextField)

                if currentModel.contradicted == "1" {
                    workInfoItemView.fillTextField.keyboardType = .numberPad
                }

            }
            self.contentHeightConstant.constant = CGFloat(105*(self.currentArrModel?.enviouslyArr.count)! + 105)
        }
    }
    
    func getBankFillInfoList(){
        let paramStr : String! = "smiled=" + LendEasy_publicMethod.obtainAnyWord() + "&" + "joyfully=" + LendEasy_publicMethod.obtainAnyWord()
        LendEasy_NetAPI.sharedInstance.requestGetAPI(urlPath: "/thing_couldnt_turned", paramsString: paramStr, ifShowError: true, ifShowStyle: true) { model in
            if model.neatly == 0 {
                if model.crows != nil {
                    self.bankModel = bankInfoModel(jsondata: model.crows!)
                    self.setUpFillInfoForm()
                }
            }
        }
    }
    
    @objc func itemClick(ges : UIGestureRecognizer){
        let currentItemView : UIView = ges.view!
        let currentItemSuperView : LendEasy_workInfoItemView = currentItemView.superview as! LendEasy_workInfoItemView
        let currentTag = currentItemView.tag
        let currentModel : bankEnviouslyModel = (self.currentArrModel?.enviouslyArr[currentTag])!
        
        if currentModel.finish == "1" {
        if currentModel.clamoring == "Select your recipient E-wallet" {
            let viewArr = Bundle.main.loadNibNamed("LendEasy_selectEwalletView", owner: nil)
            let chooseWalletTypeView : LendEasy_selectEwalletView = (viewArr![0] as! LendEasy_selectEwalletView)
            chooseWalletTypeView.frame = self.view.bounds
            chooseWalletTypeView.model = currentModel
            self.view.addSubview(chooseWalletTypeView)
            chooseWalletTypeView.selectItemBlock = { model in
                currentItemSuperView.fillTextField.text = model.shoulders
                self.basicFillInfoArr[currentModel.neatly!] = model.sooner ?? ""
            }
            return
        }
        var itemArr = [String]()
        for model : bankGlanceModel in currentModel.glanceArr {
            itemArr.append(model.shoulders ?? "")
        }
        let enumAlertView : LendEasy_EnumAlertView = LendEasy_EnumAlertView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), style: CACommonAlertStyle, itemArr: itemArr)
        enumAlertView.alertTitleLabel.text = currentModel.clamoring
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.endEditing(true)
        appdelegate.window?.addSubview(enumAlertView)
        enumAlertView.confirmBlock = { index in
            let clickModel : bankGlanceModel = currentModel.glanceArr[index]
            currentItemSuperView.fillTextField.text = clickModel.shoulders
            self.basicFillInfoArr[currentModel.neatly!] = clickModel.sooner ?? ""
        }
  
        } else if currentModel.finish == "2" {
            
        } else if currentModel.finish == "3" {
            let enumAlertView : LendEasy_EnumAlertView = LendEasy_EnumAlertView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), style: CALocationAlertStyle, itemArr: self.locArr as [Any])
            var currentIndex = 0
            var locationIndex01 : Int = 0
            var locationIndex02 : Int = 0
            let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.window?.endEditing(true)
            appdelegate.window?.addSubview(enumAlertView)
            enumAlertView.selectLocationBlock = {index in
                var currentLocModel : locationModel?
                if currentIndex == 0 {
                    locationIndex01 = index
                    currentLocModel = self.locModel?.tearingArr[index]
                    currentIndex = currentIndex + 1
                }else if currentIndex == 1 {
                    let model : locationModel! = self.locModel?.tearingArr[locationIndex01]
                    locationIndex02 = index
                    currentLocModel = model.tearingArr[index]
                    currentIndex = currentIndex + 1
                }else if currentIndex == 2 {
                    let model : locationModel! = self.locModel?.tearingArr[locationIndex01]
                    let model01 : locationModel! = model.tearingArr[locationIndex02]
                    currentLocModel = model01.tearingArr[index]
                    currentIndex = currentIndex + 1
                }
                enumAlertView.arrowIcon.isHidden = false
                if enumAlertView.locationLabel.text?.count ?? 0 > 0 {
                    enumAlertView.locationLabel.text = (enumAlertView.locationLabel.text ?? "") + "-" + (currentLocModel?.shoulders ?? "")
                }else{
                    enumAlertView.locationLabel.text = currentLocModel?.shoulders ?? ""
                }
                let arrCount = currentLocModel?.tearingArr.count ?? 0
                if  arrCount > 0 {
                    let locationArr : NSMutableArray = []
                    for i in 0...arrCount-1 {
                        let locModel : locationModel! = currentLocModel?.tearingArr[i]
                        locationArr.add(locModel.shoulders ?? "")
                    }
                    enumAlertView.itemArr = locationArr as! [Any]
                    enumAlertView.selectTitleLabelRemakeConstant()
                    enumAlertView.tableView.reloadData()
                }else{
                    enumAlertView.removeFromSuperview()
                    currentItemSuperView.fillTextField.text = enumAlertView.locationLabel.text
                    self.basicFillInfoArr[currentModel.neatly!] = enumAlertView.locationLabel.text ?? ""
                }
            }
        }
    }
    
    
    @IBAction func bindBankAction(_ sender: Any) {
        for i in 0 ... (self.currentArrModel?.enviouslyArr.count)! - 1 {
            let model : bankEnviouslyModel = (self.currentArrModel?.enviouslyArr[i])!
            if model.finish == "2" {
                for (key,_) in self.basicFillInfoArr {
                    if key == model.neatly {
                        print(model.clamoring! + "%%%%%%")
                        let fillInfoTF : UITextField! = self.fillInfoTFArr[i]
                        self.basicFillInfoArr[key] = fillInfoTF.text
                    }
                }
            }
        }
        
        self.basicFillInfoArr["warned"] = LendEasy_publicMethod.obtainAnyWord()
        if self.style == 0 {
            self.basicFillInfoArr["rained"] = "1"
        }else{
            self.basicFillInfoArr["rained"] = "2"
        }

        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/didntdidnt_sorry_little", paramsDictionary: self.basicFillInfoArr, ifShowError: true, ifShowStyle: true) { model in
            if model.neatly == 0 {
                self.fillBankInfoSuccess?()
                
                LendEasy_addPointEventTool().addPointEvent(loanID: self.loadId ?? "", jollity: "8", firstTime: self.enterTime ?? "", secondTime: LendEasy_publicMethod.getCurrentTime())
            }
        }
    }
}
