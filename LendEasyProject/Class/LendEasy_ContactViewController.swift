//
//  LendEasy_ContactViewController.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/12.
//

import UIKit
import ContactsUI
import Contacts

class LendEasy_ContactViewController: UIViewController,CNContactPickerDelegate {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollWidthConstant: NSLayoutConstraint!
    @IBOutlet weak var contentHeightConstant: NSLayoutConstraint!
    var loadId : String?
    var contactModel : contractModel?
    var contactDicList = [[String : String]]()
    var currentConstactItemView : LendEasy_contactItemView!
    var enterTime : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterTime = LendEasy_publicMethod.getCurrentTime()
        
        setUpStyleView()
        
        self.getContractListInfo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpStyleView(){
        let viewArr = Bundle.main.loadNibNamed("LendEasy_progressView", owner: nil)
        let progressView : LendEasy_progressView = viewArr![0] as! LendEasy_progressView
        progressView.secondProgressView.backgroundColor = UIColor(hex: "FF5A00")
        progressView.secondProgressView.layer.cornerRadius = 12
        progressView.secondProgressIcon.image = UIImage(named: "progress02_white")
        progressView.thirdProgressView.backgroundColor = UIColor(hex: "FF5A00")
        progressView.thirdProgressView.layer.cornerRadius = 12
        progressView.thirdProgressIcon.image = UIImage(named: "progress03_white")
        progressView.fourthProgressView.backgroundColor = UIColor(hex: "FF5A00")
        progressView.fourthProgressView.layer.cornerRadius = 12
        progressView.fourthProgressIcon.image = UIImage(named: "progress04_white")
        progressView.currentProgressView.progress = 1.0
        self.view.addSubview(progressView)
        progressView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.top.equalTo()(self.backBtn.mas_bottom)?.offset()(0)
            make?.right.offset()(0)
            make?.height.equalTo()(120)
        }
        
        button.layer.cornerRadius = 25
        self.scrollWidthConstant.constant = SCREEN_WIDTH
    }
    
    func getContractListInfo(){
        let params : [String:String] = ["stories":self.loadId!,"forever":LendEasy_publicMethod.obtainAnyWord()]
        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/davie_dinner_until", paramsDictionary: params, ifShowError: false, ifShowStyle: true, block: { model in
            if model.neatly == 0 {
                if model.crows != nil {
                    self.contactModel = contractModel(jsondata: model.crows!["skimmer"])
                    self.setUpFillInfoForm()
                    
                    for nimikmodel : tearingModel in (self.contactModel?.tearingArr)! {
                        let dic : [String:String] = ["bobbing" : nimikmodel.bobbing ?? "","shoulders" : nimikmodel.shoulders ?? "","tossed" : nimikmodel.tossed ?? "","brisk" : nimikmodel.brisk ?? ""]
                        self.contactDicList.append(dic)
                    }
                }
            }
        })
    }
    
    func setUpFillInfoForm(){
        if self.contactModel?.tearingArr.count ?? 0 > 0 {
            for i in 0...(self.contactModel?.tearingArr.count)! - 1 {
                let viewArr = Bundle.main.loadNibNamed("LendEasy_contactItemView", owner: nil)
                let constactItemView : LendEasy_contactItemView = viewArr![0] as! LendEasy_contactItemView
                constactItemView.relationShipView.tag = i
                constactItemView.phoneView.tag = i
                constactItemView.relationshipTextField.isUserInteractionEnabled = false
                constactItemView.phoneNumberTextField.isUserInteractionEnabled = false
                self.contentView.addSubview(constactItemView)
                constactItemView.mas_makeConstraints { make in
                    make?.left.offset()(0)
                    make?.top.offset()(CGFloat(250*i))
                    make?.height.equalTo()(250)
                    make?.right.offset()(0)
                }
                let relationShipTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectedRelationShipAction))
                constactItemView.relationShipView.addGestureRecognizer(relationShipTap)
                
                let selectPhoneNumTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectPhoneNumAction))
                constactItemView.phoneView.addGestureRecognizer(selectPhoneNumTap)
                
                let currentModel : tearingModel = (self.contactModel?.tearingArr[i])!
                constactItemView.emergencyTitleLabel.text = currentModel.hardest ?? ""
                if currentModel.shoulders?.count ?? 0 > 0 {
                    constactItemView.phoneNumberTextField.text = (currentModel.shoulders ?? "") + "-" + (currentModel.bobbing ?? "")
                }
                for model : nimikModel in currentModel.nimikArr {
                    if model.sooner == currentModel.tossed {
                        constactItemView.relationshipTextField.text = model.shoulders
                    }
                }

            }
        }
        self.contentHeightConstant.constant = CGFloat(250*(self.contactModel?.tearingArr.count)!)
    }

    @objc func selectedRelationShipAction(ges : UIGestureRecognizer){
        let currentItemView : UIView = ges.view!
        let currentItemSuperView : LendEasy_contactItemView = currentItemView.superview as! LendEasy_contactItemView
        let currentTag = currentItemView.tag
        let currentModel : tearingModel = (self.contactModel?.tearingArr[currentTag])!
        
        var itemArr = [String]()
        for model : nimikModel in currentModel.nimikArr {
            itemArr.append(model.shoulders ?? "")
        }
        let enumAlertView : LendEasy_EnumAlertView = LendEasy_EnumAlertView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), style: CACommonAlertStyle, itemArr: itemArr)
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.endEditing(true)
        appdelegate.window?.addSubview(enumAlertView)
        enumAlertView.confirmBlock = { index in
            let clickModel : nimikModel = currentModel.nimikArr[index]
            currentItemSuperView.relationshipTextField.text = clickModel.shoulders ?? ""
            
            var dic = self.contactDicList[currentTag]
            dic["tossed"] = clickModel.sooner!
            self.contactDicList[currentTag] = dic
        }
    }
    
    @objc func selectPhoneNumAction(ges : UIGestureRecognizer){
        self.currentConstactItemView = ges.view?.superview as? LendEasy_contactItemView
        let contractPickerVC : CNContactPickerViewController = CNContactPickerViewController()
        contractPickerVC.delegate = self
        self.present(contractPickerVC, animated: true)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        if contact.phoneNumbers.count == 0 {
            return
        }
        let phoneNumber : CNPhoneNumber? = contact.phoneNumbers[0].value
        if phoneNumber != nil {
            self.currentConstactItemView.phoneNumberTextField.text = contact.familyName + contact.givenName + "-" + (phoneNumber?.stringValue ?? "")
            
        }
        
        var dic : [String:String] = self.contactDicList[self.currentConstactItemView.phoneView.tag]
        dic["bobbing"] = phoneNumber?.stringValue
        dic["shoulders"] = contact.familyName + contact.givenName
        self.contactDicList[self.currentConstactItemView.phoneView.tag] = dic
    }
    
    
    @IBAction func operationAction(_ sender: Any) {
        do{
            let jsonData : Data = try JSONSerialization.data(withJSONObject: self.contactDicList)
            let jsonStr = String(data: jsonData, encoding: .utf8)
            let params : [String:Any] = ["stories":self.loadId ?? "","crows":jsonStr!]
            LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/wrinkling_magnificent_youll", paramsDictionary: params, ifShowError: true, ifShowStyle: true) { model in
                if model.neatly == 0 {
                    self.navigationController?.popViewController(animated: true)
                    
                    LendEasy_addPointEventTool().addPointEvent(loanID: self.loadId ?? "", jollity: "7", firstTime: self.enterTime ?? "", secondTime: LendEasy_publicMethod.getCurrentTime())
                }
            }
        }catch{
              
          }
    }
}
