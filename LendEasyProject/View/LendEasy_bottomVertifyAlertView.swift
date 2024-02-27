//
//  LendEasy_bottomVertifyAlertView.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/24.
//

import UIKit
import Kingfisher
import SVProgressHUD
class LendEasy_bottomVertifyAlertView: UIView {
    @IBOutlet weak var bottomWhiteView: UIView!
    @IBOutlet weak var item01: UIView!
    @IBOutlet weak var item02: UIView!
    @IBOutlet weak var item03: UIView!
    @IBOutlet weak var item04: UIView!
    @IBOutlet weak var itemIcon01: UIImageView!
    @IBOutlet weak var itemTitleLabel01: UILabel!
    @IBOutlet weak var itemSubtitleLabel01: UILabel!
    @IBOutlet weak var itemIcon02: UIImageView!
    @IBOutlet weak var itemTitleLabel02: UILabel!
    @IBOutlet weak var itemSubtitleLabel02: UILabel!
    @IBOutlet weak var itemIcon03: UIImageView!
    @IBOutlet weak var itemTitleLabel03: UILabel!
    @IBOutlet weak var itemSubtitleLabel03: UILabel!
    @IBOutlet weak var itemIcon04: UIImageView!
    @IBOutlet weak var itemTitleLabel04: UILabel!
    @IBOutlet weak var itemSubtitleLabel04: UILabel!
    var vertifyModel : vertifyListModel!
    var checkItem01Block:((whirlingModel)->())?
    var checkItem02Block:((whirlingModel)->())?
    var checkItem03Block:((whirlingModel)->())?
    var checkItem04Block:((whirlingModel)->())?
    override func awakeFromNib() {
        self.bottomWhiteView.layer.cornerRadius = 12
        item01.layer.cornerRadius = 12
        item02.layer.cornerRadius = 12
        item03.layer.cornerRadius = 12
        item04.layer.cornerRadius = 12
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    var model : vertifyListModel {
        set {
            self.vertifyModel = newValue
            self.setUpViewStyle()
        }
        
        get {
            return (self.vertifyModel)
        }
    }
    
    func setUpViewStyle(){
        if self.vertifyModel.whirlingArr.count > 0 {
            let firstModel : whirlingModel = self.vertifyModel.whirlingArr[0]
            self.itemIcon01.kf.setImage(with: URL(string: firstModel.generously ?? ""), placeholder:UIImage(named: "item01"))
            self.itemTitleLabel01.text = firstModel.clamoring
            self.itemSubtitleLabel01.text = firstModel.instant
            
            self.item01.isUserInteractionEnabled = true
            let tap01 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(checkItem01Action))
            self.item01.addGestureRecognizer(tap01)
        }
        
        if self.vertifyModel.whirlingArr.count > 1 {
            let secondModel : whirlingModel = self.vertifyModel.whirlingArr[1]
            self.itemIcon02.kf.setImage(with: URL(string: secondModel.generously ?? ""), placeholder:UIImage(named: "item02"))
            self.itemTitleLabel02.text = secondModel.clamoring
            self.itemSubtitleLabel02.text = secondModel.instant
            
            self.item02.isUserInteractionEnabled = true
            let tap02 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(checkItem02Action))
            self.item02.addGestureRecognizer(tap02)
        }
        
        if self.vertifyModel.whirlingArr.count > 2 {
            let thirdModel : whirlingModel = self.vertifyModel.whirlingArr[2]
            self.itemIcon03.kf.setImage(with: URL(string: thirdModel.generously ?? ""), placeholder:UIImage(named: "item03"))
            self.itemTitleLabel03.text = thirdModel.clamoring
            self.itemSubtitleLabel03.text = thirdModel.instant
            
            self.item03.isUserInteractionEnabled = true
            let tap03 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(checkItem03Action))
            self.item03.addGestureRecognizer(tap03)
        }
        
        if self.vertifyModel.whirlingArr.count > 3 {
            let fourthModel : whirlingModel = self.vertifyModel.whirlingArr[3]
            self.itemIcon04.kf.setImage(with: URL(string: fourthModel.generously ?? ""), placeholder:UIImage(named: "item04"))
            self.itemTitleLabel04.text = fourthModel.clamoring
            self.itemSubtitleLabel04.text = fourthModel.instant
            
            self.item04.isUserInteractionEnabled = true
            let tap04 : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(checkItem04Action))
            self.item04.addGestureRecognizer(tap04)
        }
    }
    
    @objc func checkItem01Action(){
        let item01Model : whirlingModel = self.vertifyModel.whirlingArr[0]
        if item01Model.silently == 1 {
            self.removeFromSuperview()
            checkItem01Block?(item01Model)
        }else{
            SVProgressHUD.showError(withStatus: "You haven't filled out the " + item01Model.clamoring! + "information yet, go fill it out quickly")
        }
    }
    
    @objc func checkItem02Action(){
        let item02Model : whirlingModel = self.vertifyModel.whirlingArr[1]
        if item02Model.silently == 1 {
            self.removeFromSuperview()
            checkItem02Block?(item02Model)
        }else{
            SVProgressHUD.showError(withStatus: "You haven't filled out the " + item02Model.clamoring! + "information yet, go fill it out quickly")
        }
    }
    
    @objc func checkItem03Action(){
        let item03Model : whirlingModel = self.vertifyModel.whirlingArr[2]
        if item03Model.silently == 1 {
            self.removeFromSuperview()
            checkItem03Block?(item03Model)
        }else{
            SVProgressHUD.showError(withStatus: "You haven't filled out the " + item03Model.clamoring! + "information yet, go fill it out quickly")
        }
    }
    
    @objc func checkItem04Action(){
        let item04Model : whirlingModel = self.vertifyModel.whirlingArr[3]
        if item04Model.silently == 1 {
            self.removeFromSuperview()
            checkItem04Block?(item04Model)
        }else{
            SVProgressHUD.showError(withStatus: "You haven't filled out the " + item04Model.clamoring! + "information yet, go fill it out quickly")
        }
    }
}
