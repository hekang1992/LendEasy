//
//  LendEasy_AuthenticationListViewController.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/11.
//

import UIKit

class LendEasy_AuthenticationListViewController: UIViewController {
    @IBOutlet weak var bannerIcon: UIImageView!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var currentProgressView: UIProgressView!
    @IBOutlet weak var currentProgressIcon: UIImageView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var scrollviewWidth: NSLayoutConstraint!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyle()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpStyle(){
        self.scrollviewWidth.constant = SCREEN_WIDTH
        self.progressView.layer.cornerRadius = 16
        self.progressView.layer.borderColor = UIColor(hex: "E2E4EA").cgColor
        self.progressView.layer.borderWidth = 1.0
        
        self.button.layer.cornerRadius = 25
        
        self.currentProgressView.progress = 0.25
        self.currentProgressIcon.mas_remakeConstraints { make in
            make?.left.offset()(20 + (SCREEN_WIDTH - 40 - 36)*0.25)
            make?.centerY.equalTo()(self.currentProgressView)
            make?.height.equalTo()(12)
            make?.width.equalTo()(12)
        }
        
        self.firstView.isUserInteractionEnabled = true
        let tap01 : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(clickViewAction))
        self.firstView.addGestureRecognizer(tap01)
        
        self.secondView.isUserInteractionEnabled = true
        let tap02 : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(clickViewAction))
        self.secondView.addGestureRecognizer(tap02)
        
        self.thirdView.isUserInteractionEnabled = true
        let tap03 : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(clickViewAction))
        self.thirdView.addGestureRecognizer(tap03)
        
        self.fourthView.isUserInteractionEnabled = true
        let tap04 : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(clickViewAction))
        self.fourthView.addGestureRecognizer(tap04)
    }
    
    
    @IBAction func applyAction(_ sender: Any) {
        
    }
    
    @objc func clickViewAction(_ ges : UIGestureRecognizer){
        let tag = ges.view?.tag
        if tag == 0 {
            let basicInfoFillVC : LendEasy_FillBasicInfoViewController = LendEasy_FillBasicInfoViewController()
            self.navigationController?.pushViewController(basicInfoFillVC, animated: true)
        }else if tag == 1 {
            let chooseIDViewController : LendEasy_ChooseIDViewController = LendEasy_ChooseIDViewController()
            self.navigationController?.pushViewController(chooseIDViewController, animated: true)
        }else if tag == 2 {
            let workInfoVC : LendEasy_workInfomationViewController = LendEasy_workInfomationViewController()
            self.navigationController?.pushViewController(workInfoVC, animated: true)
        }else{
            let contactVC : LendEasy_ContactViewController = LendEasy_ContactViewController()
            self.navigationController?.pushViewController(contactVC, animated: true)
        }
    }
}
