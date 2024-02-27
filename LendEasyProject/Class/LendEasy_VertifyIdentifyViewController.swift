//
//  LendEasy_VertifyIdentifyViewController.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/12.
//

import UIKit
import AVFoundation
import AAILiveness
class LendEasy_VertifyIdentifyViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var vertifyTitleLabel: UILabel!
    @IBOutlet weak var firstIdentifyView: UIView!
    @IBOutlet weak var takePhotoImageView: UIImageView!
    @IBOutlet weak var takePhotoTipLabel: UILabel!
    @IBOutlet weak var secondIdentifyView: UIView!
    @IBOutlet weak var frontPhotoImageView: UIImageView!
    @IBOutlet weak var faceRegImageView: UIImageView!
    @IBOutlet weak var faceRegExampleImageView: UIImageView!
    @IBOutlet weak var safeTipIcon: UIImageView!
    @IBOutlet weak var safeTipLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var changeBtn: UIButton!
    
    @IBOutlet weak var cardTypeLabel: UILabel!
    @IBOutlet weak var scrollviewWidth: NSLayoutConstraint!
    @IBOutlet weak var uploadSuccessView02: UIView!
    @IBOutlet weak var uploadSuccessView01: UIView!
    var titleStr : String?
    var idStr : String?
    var sooner : String?
    var drops : String?
    var loadId : String?
    var idCardModel : IDCardInfoModel?
    var model : identifyModel!
    var advanceModel : advanceInfoModel?
    var currentIdentifyIndex : Int = 0
    var enterTime : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AAILivenessSDK.initWith(.philippines)
        
        self.enterTime = LendEasy_publicMethod.getCurrentTime()

        setUpStyleView()
        
//        getAdvanceInfo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func backAction(_ sender: Any) {
        if currentIdentifyIndex == 0 {
            self.navigationController?.popViewController(animated: true)
        }else{
            let vc = self.navigationController?.viewControllers[1]
            self.navigationController?.popToViewController(vc!, animated: true)
        }
    }
    
    func setUpStyleView(){
        self.safeTipIcon.isHidden = true
        self.safeTipLabel.isHidden = true
        self.button.isHidden = true
        
        self.vertifyTitleLabel.text = self.titleStr
        
        self.frontPhotoImageView.kf.setImage(with: URL(string: "https://www.dancepeso.com/ez/ssid_oc?sooner=" + (self.idStr ?? "") + "&" + "brisk=1"))
        
        let viewArr = Bundle.main.loadNibNamed("LendEasy_progressView", owner: nil)
        let progressView : LendEasy_progressView = viewArr![0] as! LendEasy_progressView
        self.view.addSubview(progressView)
        progressView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.top.equalTo()(self.backButton.mas_bottom)?.offset()(0)
            make?.right.offset()(0)
            make?.height.equalTo()(120)
        }
        
        self.changeBtn.isHidden = false
        button.layer.cornerRadius = 25
        self.changeBtn.layer.borderWidth = 0.5
        self.changeBtn.layer.cornerRadius = 12
        self.changeBtn.layer.borderColor = UIColor(hex: "FF5A00").cgColor
        self.scrollviewWidth.constant = SCREEN_WIDTH
        
        self.frontPhotoImageView.layer.cornerRadius = 12
        self.faceRegImageView.layer.cornerRadius = 12

        self.firstIdentifyView.isUserInteractionEnabled = true
        let tap01 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addFrontPhotoOfIDCardAction))
        self.firstIdentifyView.addGestureRecognizer(tap01)
        
        self.secondIdentifyView.isUserInteractionEnabled = true
        let tap02 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addFacialRecognition))
        self.secondIdentifyView.addGestureRecognizer(tap02)
        
        self.uploadSuccessView01.layer.cornerRadius = 12
        self.uploadSuccessView02.layer.cornerRadius = 12
        self.uploadSuccessView01.isHidden = true
        self.uploadSuccessView02.isHidden = true
        
        self.cardTypeLabel.text = self.idStr
        self.takePhotoTipLabel.text = "Front photo of " + (self.idStr ?? "")
        
        if self.model.overcome?.silently == 1 {
            self.changeBtn.isHidden = true
            self.currentIdentifyIndex = 1
            self.frontPhotoImageView.kf.setImage(with: URL(string:(self.model.overcome?.recklessly)!))
            self.takePhotoImageView.isHidden = true
            self.takePhotoTipLabel.isHidden = true
            self.firstIdentifyView.isUserInteractionEnabled = false
            self.uploadSuccessView01.isHidden = false
            self.cardTypeLabel.text = self.model.overcome?.rained ?? ""
            self.takePhotoTipLabel.text = "Front photo of " + (self.model.overcome?.rained ?? "")
        }
        
        if self.model.bumped == 1 {
            self.changeBtn.isHidden = true
            self.currentIdentifyIndex = 2
            self.secondIdentifyView.isUserInteractionEnabled = false
            self.faceRegExampleImageView.isHidden = true
            self.faceRegImageView.kf.setImage(with: URL(string: self.model.recklessly!))
            self.uploadSuccessView02.isHidden = false
        }
    }
    
    @objc func addFrontPhotoOfIDCardAction(){
        self.sooner = "11"
        if self.model.sooner == "1" {
            self.showSelectePhotoSheetView(ifTwoType: true,ifFaceReg: false,ifFace: false)

        }else{
            self.showSelectePhotoSheetView(ifTwoType: false ,ifFaceReg: false,ifFace: false)
        }
    }
    
    @objc func addFacialRecognition(){
        if(self.currentIdentifyIndex == 0){
            self.addFrontPhotoOfIDCardAction()
            return
        }
        self.sooner = "10"
        if self.advanceModel?.misery == "1" {
            self.showSelectePhotoSheetView(ifTwoType: false,ifFaceReg: false,ifFace: true)
        }else{
            self.showSelectePhotoSheetView(ifTwoType: false,ifFaceReg: true,ifFace: true)
        }
    }
    
    func showSelectePhotoSheetView(ifTwoType : Bool,ifFaceReg : Bool,ifFace : Bool){
        let viewArr = Bundle.main.loadNibNamed("LendEasy_cardExampleView", owner: nil)
        let exampleAlertView : LendEasy_cardExampleView = viewArr![0] as! LendEasy_cardExampleView
        exampleAlertView.frame = self.view.bounds
        self.view.addSubview(exampleAlertView)
        
        exampleAlertView.firstOperationBlock = {
            self.takePhoto(ifFace: false)
        }
        
        exampleAlertView.secondOperationBlock = {
            self.choosePicFromAlbum()
        }
        
        if ifTwoType == false {
            exampleAlertView.bottomviewHeightContant.constant = 102
            exampleAlertView.firstOperationBtn.isHidden = true
            if ifFaceReg == false {
                exampleAlertView.secondOperationBtn.setTitle("Take Photo", for: .normal)
                exampleAlertView.secondOperationBlock = {
                    self.takePhoto(ifFace: ifFace)
                }
            }else{
                exampleAlertView.secondOperationBtn.setTitle("Start Facial Authentication", for: .normal)
                exampleAlertView.secondOperationBlock = {
                    self.checkLicenseAndShowSDK()
                }
            }
        }
        
        if ifFace == true {
            exampleAlertView.rightExampleIcon.image = UIImage(named: "faceReg_icon")
            exampleAlertView.widthContant.constant = 180
            exampleAlertView.firstErrorExampleIcon.image = UIImage(named: "face_error01")
            exampleAlertView.secondErrorExampleIcon.image = UIImage(named: "face_error02")
            exampleAlertView.thirdErrorExampleIcon.image = UIImage(named: "face_error03")
        }else{
            exampleAlertView.rightExampleIcon.kf.setImage(with: URL(string: "https://www.dancepeso.com/ez/ssid_oc?sooner=" + (self.idStr ?? "") + "&" + "brisk=1"))
            exampleAlertView.firstErrorExampleIcon.kf.setImage(with: URL(string: "https://www.dancepeso.com/ez/ssid_oc?sooner=" + (self.idStr ?? "") + "&" + "brisk=2"))
            exampleAlertView.secondErrorExampleIcon.kf.setImage(with: URL(string: "https://www.dancepeso.com/ez/ssid_oc?sooner=" + (self.idStr ?? "") + "&" + "brisk=3"))
            exampleAlertView.thirdErrorExampleIcon.kf.setImage(with: URL(string: "https://www.dancepeso.com/ez/ssid_oc?sooner=" + (self.idStr ?? "") + "&" + "brisk=4"))
        }
        
    }
    
    func takePhoto(ifFace : Bool){
        self.drops = "2"
        if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
            return
        }
        
        let authStatus : AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if authStatus == .restricted || authStatus == .denied {
            let alertVC : UIAlertController = UIAlertController(title: nil, message: "We need access to your camera to verify the authenticity of your identification documents and prevent fraudulent activities. Please allow us to use your camera for secure capture of your identification documents.", preferredStyle: .alert)
            let action0 : UIAlertAction = UIAlertAction(title: "Cancel", style: .default) { action in
                
            }
            let action1 : UIAlertAction = UIAlertAction(title: "To set", style: .default) { action in
                let url = URL(string: UIApplication.openSettingsURLString)!
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url)
                }
            }
            alertVC.addAction(action0)
            alertVC.addAction(action1)
            
            self.present(alertVC, animated: true)
            return
        }
        
        let picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        if ifFace == true {
            picker.cameraDevice = .front
        }
        picker.allowsEditing = true
        picker.modalPresentationStyle = .fullScreen
        self.present(picker, animated: true)
    }
    
    func choosePicFromAlbum(){
        self.drops = "1"
        if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
            return
        }
        
        let authStatus : AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if authStatus == .restricted || authStatus == .denied {
            let alertVC : UIAlertController = UIAlertController(title: nil, message: "We need access to your camera to verify the authenticity of your identification documents and prevent fraudulent activities. Please allow us to use your camera for secure capture of your identification documents.", preferredStyle: .alert)
            let action0 : UIAlertAction = UIAlertAction(title: "Cancel", style: .default) { action in
                
            }
            let action1 : UIAlertAction = UIAlertAction(title: "To set", style: .default) { action in
                let url = URL(string: UIApplication.openSettingsURLString)!
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url)
                }
            }
            alertVC.addAction(action0)
            alertVC.addAction(action1)
            
            self.present(alertVC, animated: true)
            return
        }
        
        let picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = true
        picker.modalPresentationStyle = .fullScreen
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        let image : UIImage! = info[.originalImage] as? UIImage
        self.uploadImageToService(uploadImage: image,streaked: "")
    }
    
    func uploadImageToService(uploadImage : UIImage,streaked : String){
        let params : [String:Any] = ["drops":self.drops ?? "","stories":self.loadId ?? "","sooner":self.sooner!,"rattle":LendEasy_publicMethod.obtainAnyWord(),"misery":self.advanceModel?.misery ?? "","rained":self.idStr ?? "","streaked" : streaked]
        LendEasy_NetAPI.sharedInstance.uploadImageAPI(urlPath: "/outwhy_childs_began", paramsDic: params, image:uploadImage , imageName: "grimy", ifShowError: true, ifShowStyle: true) { model in
            if model.neatly == 0 {
                if model.crows != nil {
                    if self.sooner == "11" {
                        self.frontPhotoImageView.image = uploadImage
                        self.takePhotoImageView.isHidden = true
                        self.takePhotoTipLabel.isHidden = true
                        
                        self.idCardModel = IDCardInfoModel(jsondata: model.crows!)
                        let userInfoAlertView : LendEasy_ConfirmCardInfoAlertView = LendEasy_ConfirmCardInfoAlertView(frame: self.view.bounds, nameResult: self.idCardModel?.shoulders ?? "", numberResult: self.idCardModel?.effect ?? "", birthNo: self.idCardModel?.adding ?? "")
                        self.view.addSubview(userInfoAlertView)
                        userInfoAlertView.cancelBlock = {
                            self.frontPhotoImageView.kf.setImage(with: URL(string: "https://www.dancepeso.com/ez/ssid_oc?sooner=" + (self.idStr ?? "") + "&" + "brisk=1"))
                            self.takePhotoImageView.isHidden = false
                            self.takePhotoTipLabel.isHidden = false
                        }
                        
                        userInfoAlertView.confirmBlock = { nameStr, cardNumStr, birthDateStr in
                            self.saveUserIDCardInfo(nameStr: nameStr, cardNumStr: cardNumStr, birthDateStr: birthDateStr)
                        }
                        
                        userInfoAlertView.chooseTimeBlock = { textfield in
                            let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                            appdelegate.window?.endEditing(true)
                            let chooseDateView : LendEasy_ChooseDateAlertView = LendEasy_ChooseDateAlertView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), dateStr: self.idCardModel?.adding ?? "")
                            appdelegate.window?.addSubview(chooseDateView)
                            chooseDateView.confirmBlock = { dateStr in
                                textfield.text = dateStr
                            }
                        }
                    }else{
                        self.changeBtn.isHidden = true
                        self.faceRegImageView.image = uploadImage
                        self.faceRegExampleImageView.isHidden = true
                        
                        self.uploadSuccessView02.isHidden = false
                        
                        let vc = self.navigationController?.viewControllers[1]
                        self.navigationController?.popToViewController(vc!, animated: true)
                        
                        LendEasy_addPointEventTool().addPointEvent(loanID: self.loadId ?? "", jollity: "4", firstTime: self.enterTime ?? "", secondTime: LendEasy_publicMethod.getCurrentTime())
                    }
              

                }
                        
            }
        }
    }
    
    func saveUserIDCardInfo(nameStr : String,cardNumStr : String,birthDateStr : String){
        let params : [String:Any] = ["adding":birthDateStr,"effect":cardNumStr,"shoulders":nameStr,"sooner":self.sooner!,"rained":self.idStr ?? "","breakfasts":LendEasy_publicMethod.obtainAnyWord()]
        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/theres_thing_stairs", paramsDictionary: params, ifShowError: true, ifShowStyle: true) { model in
            if model.neatly != 0 {
                self.frontPhotoImageView.kf.setImage(with: URL(string: "https://www.dancepeso.com/ez/ssid_oc?sooner=" + (self.idStr ?? "") + "&" + "brisk=1"))
                self.takePhotoImageView.isHidden = false
                self.takePhotoTipLabel.isHidden = false
            }else{
                self.firstIdentifyView.isUserInteractionEnabled = false
                self.uploadSuccessView01.isHidden = false

                self.changeBtn.isHidden = true
                self.currentIdentifyIndex = 1
                self.addFacialRecognition()
                
                LendEasy_addPointEventTool().addPointEvent(loanID: self.loadId ?? "", jollity: "3", firstTime: self.enterTime ?? "", secondTime: LendEasy_publicMethod.getCurrentTime())
            }
        }
    }
    
    func getAdvanceInfo(){
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.advanceModel = appdelegate.advanceModel
    }
    
    func checkLicenseAndShowSDK() {
        let params : [String:Any] = ["blodgett":LendEasy_publicMethod.obtainAnyWord(),"banging":LendEasy_publicMethod.obtainAnyWord()]
        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/exclaimed_little_badly", paramsDictionary: params, ifShowError: true, ifShowStyle: true) { model in
            if model.neatly == 0 {
                if model.crows != nil {
                    self.advanceModel = advanceInfoModel(jsondata: model.crows!)
                    let checkResult = AAILivenessSDK.configLicenseAndCheck(self.advanceModel?.reiterated ?? "")
                    if checkResult == "SUCCESS" {
                        self.showSDK()
                    } else if checkResult == "LICENSE_EXPIRE" {
                        print("LICENSE_EXPIRE: please call your server's api to generate a new license")
                    } else if checkResult == "APPLICATION_ID_NOT_MATCH" {
                        print("APPLICATION_ID_NOT_MATCH: please bind your app's bundle identifier on our cms website, then recall your server's api to generate a new license")
                    } else {
                        print("\(checkResult)")
                    }
                }
            }
        }
    }
    
    func showSDK() {
            let vc = AAILivenessViewController()
            vc.detectionSuccessBlk = {(rawVC, result) in
                let livenessId = result.livenessId
                let bestImg = result.img
                let size = bestImg.size
                print(">>>>>livenessId: \(livenessId), imgSize: \(size.width), \(size.height)")
                rawVC.navigationController?.popViewController(animated: true)
                self.uploadImageToService(uploadImage: bestImg, streaked: livenessId)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    
    
    @IBAction func changeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
