//
//  LendEasy_FillBasicInfoViewController.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/12.
//

import UIKit

class LendEasy_FillBasicInfoViewController: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var widthContrait: NSLayoutConstraint!
    @IBOutlet weak var heightConstrait: NSLayoutConstraint!
    var loadId : String?
    var basicInfoModel : BasicInfoModel?
    var locModel : locationModel?
    var locArr = [String]()
    var basicFillInfoArr : [String : String] = [:]
    var fillInfoTFArr = [UITextField]()
    var enterTime : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterTime = LendEasy_publicMethod.getCurrentTime()
        
        setUpStyleView()
        
        self.getLocInfoList()
        self.getPersoninfoFillList()
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
        progressView.currentProgressView.progress = 0.5
        self.view.addSubview(progressView)
        progressView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.top.equalTo()(self.backBtn.mas_bottom)?.offset()(0)
            make?.right.offset()(0)
            make?.height.equalTo()(120)
        }
        
        button.layer.cornerRadius = 25
        widthContrait.constant = SCREEN_WIDTH
        
    }


    func getPersoninfoFillList(){
        let params : [String:String] = ["stories":self.loadId!]
        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/jackets_declared_could", paramsDictionary: params, ifShowError: false, ifShowStyle: true, block: { model in
            if model.neatly == 0 {
                if model.crows != nil {
                    self.basicInfoModel = BasicInfoModel(jsondata: model.crows!)
                    self.setUpFillInfoForm()
                    
                    for enviouslymodel : enviouslyModel in (self.basicInfoModel?.enviouslyArr)! {
                        self.basicFillInfoArr[enviouslymodel.neatly!] = enviouslymodel.sooner
                    }
                }
            }
        })
    }
    
    func getLocInfoList(){
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.locModel = appdelegate.locModel
        for loctionmodel : locationModel in (self.locModel?.tearingArr)! {
            self.locArr.append(loctionmodel.shoulders!)
        }
    }
    
    func setUpFillInfoForm(){
        if self.basicInfoModel?.enviouslyArr.count ?? 0 > 0 {
            for i in 0...(self.basicInfoModel?.enviouslyArr.count)! - 1 {
                let viewArr = Bundle.main.loadNibNamed("LendEasy_workInfoItemView", owner: nil)
                let workInfoItemView : LendEasy_workInfoItemView = viewArr![0] as! LendEasy_workInfoItemView
                self.scrollContentView.addSubview(workInfoItemView)
                workInfoItemView.mas_makeConstraints { make in
                    make?.left.offset()(0)
                    make?.top.offset()(CGFloat(105*i))
                    make?.height.equalTo()(105)
                    make?.right.offset()(0)
                }
                
                let currentModel : enviouslyModel = (self.basicInfoModel?.enviouslyArr[i])!
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
            self.heightConstrait.constant = CGFloat(105*(self.basicInfoModel?.enviouslyArr.count)!)
        }
    }
    
    @objc func itemClick(ges : UIGestureRecognizer){
        let currentItemView : UIView = ges.view!
        let currentItemSuperView : LendEasy_workInfoItemView = currentItemView.superview as! LendEasy_workInfoItemView
        let currentTag = currentItemView.tag
        let currentModel : enviouslyModel = (self.basicInfoModel?.enviouslyArr[currentTag])!
        
        if currentModel.finish == "1" {
        var itemArr = [String]()
        for model :glanceModel in currentModel.glanceArr {
            itemArr.append(model.shoulders)
        }
        let enumAlertView : LendEasy_EnumAlertView = LendEasy_EnumAlertView.init(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), style: CACommonAlertStyle, itemArr: itemArr)
        enumAlertView.alertTitleLabel.text = currentModel.clamoring
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.endEditing(true)
        appdelegate.window?.addSubview(enumAlertView)
        enumAlertView.confirmBlock = { index in
            let clickModel : glanceModel = currentModel.glanceArr[index]
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
    
    
    @IBAction func confirmToSubmitAction(_ sender: Any) {
        for i in 0 ... (self.basicInfoModel?.enviouslyArr.count)! - 1 {
            let model : enviouslyModel = (self.basicInfoModel?.enviouslyArr[i])!
            if model.finish == "2" {
                for (key,_) in self.basicFillInfoArr {
                    if key == model.neatly {
                        let fillInfoTF : UITextField! = self.fillInfoTFArr[i]
                        self.basicFillInfoArr[key] = fillInfoTF.text
                    }
                }
            }
        }
        
        self.basicFillInfoArr["banging"] = LendEasy_publicMethod.obtainAnyWord()
        self.basicFillInfoArr["stories"] = self.loadId

        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/children_polly_comingspringing", paramsDictionary: self.basicFillInfoArr, ifShowError: true, ifShowStyle: true) { model in
            if model.neatly == 0 {
                self.navigationController?.popViewController(animated: true)
                
                LendEasy_addPointEventTool().addPointEvent(loanID: self.loadId ?? "", jollity: "5", firstTime: self.enterTime ?? "", secondTime: LendEasy_publicMethod.getCurrentTime())
            }
        }
    }
}
