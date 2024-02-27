//
//  LendEasy_selectEwalletView.swift
//  LendEasyProject
//
//  Created by Apple on 2023/11/1.
//

import UIKit

class LendEasy_selectEwalletView: UIView {
    @IBOutlet weak var alertContentView: UIView!
    @IBOutlet weak var topBgView: UIView!
    @IBOutlet weak var contentHeightContant: NSLayoutConstraint!
    @IBOutlet weak var widthContant: NSLayoutConstraint!
    @IBOutlet weak var heightContant: NSLayoutConstraint!
    @IBOutlet weak var scrollContentView: UIView!
    var selectItemBlock:((bankGlanceModel)->())?
    var ganlanceModel : bankEnviouslyModel!
    override func awakeFromNib() {
        self.alertContentView.layer.cornerRadius = 12
        self.contentHeightContant.constant = SCREEN_HEIGHT/2
        LendEasy_EnumAlertView.insertTopShadow(self.topBgView, from: UIColor(hex: "FF5A00").withAlphaComponent(0.1), to: UIColor.white)
        
        widthContant.constant = SCREEN_WIDTH - 16
    }
    
    var model : bankEnviouslyModel {
        set {
            self.ganlanceModel = newValue
            self.setUpViewStyle()
        }
        
        get {
            return (self.ganlanceModel)
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    func setUpViewStyle(){
        var i = 0
        self.heightContant.constant = CGFloat(self.ganlanceModel.glanceArr.count * 60)
        for model : bankGlanceModel in self.ganlanceModel.glanceArr{
            let viewArr = Bundle.main.loadNibNamed("LendEasy_walletItemView", owner: nil)
            let walletItemView = (viewArr![0] as! LendEasy_walletItemView)
            self.scrollContentView.addSubview(walletItemView)
            walletItemView.mas_makeConstraints { make in
                make?.height.equalTo()(50)
                make?.top.offset()(CGFloat(60*i))
                make?.left.offset()(16)
                make?.right.offset()(-16)
            }
            
            walletItemView.walletIcon.kf.setImage(with: URL(string: model.exclaim ?? ""))
            walletItemView.walletName.text = model.shoulders ?? ""
            
            walletItemView.tag = i
            i = i + 1
            
            let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickWalletAction))
            walletItemView.isUserInteractionEnabled = true
            walletItemView.addGestureRecognizer(tap)
        }
        
    }
    
    @objc func clickWalletAction(ges : UIGestureRecognizer){
        self.removeFromSuperview()
        let tag = ges.view?.tag
        let model : bankGlanceModel = self.ganlanceModel.glanceArr[tag!]
        selectItemBlock?(model)
    }
    
}
