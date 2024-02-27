//
//  LendEasy_LeftViewController.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/7.
//

import UIKit
import SVProgressHUD
class LendEasy_LeftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var tableview : UITableView!
    var tableviewHeaderView : UIView!
    var tableviewFooterView : UIView!
    var headerIcon : UIImageView!
    var telLabel : UILabel!
    var loginBtn : UIButton!
    var cancellationBtn : UIButton!
    var firstSectionArr = ["Pending repayment","Payment failed","In progress","Order completed"]
    var secondSectionArr = ["Loan&Privacy Agreement","Bank Card","Contact Us","About Us"]
    var firstSectionIconArr = ["mine01","mine02","mine03","mine04"]
    var secondSectionIconArr = ["mine05","mine06","mine07","mine08"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "F3F5F7")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpStyleView()
    }
    
    func setUpStyleView(){
        let bgImageView = UIImageView(image: UIImage(named: "personal_centerBg"))
        bgImageView.contentMode = .scaleAspectFill
        self.view.addSubview(bgImageView)
        bgImageView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.offset()(0)
            make?.bottom.offset()(0)
        }
        
        self.tableview = UITableView.init()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.backgroundColor = UIColor.clear
        self.tableview.showsVerticalScrollIndicator = false
        self.tableview.showsHorizontalScrollIndicator = false
        self.tableview.separatorStyle = .none
        self.view.addSubview(self.tableview)
        self.tableview.mas_makeConstraints { make in
            make?.top.offset()(0)
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.bottom.offset()(0)
        }
        if #available(iOS 11.0, *) {
            self.tableview.contentInsetAdjustmentBehavior = .never
        }
        
        if #available(iOS 15.0, *) {
            self.tableview.sectionHeaderTopPadding = 0
        }
        self.tableview.tableHeaderView = self.setTableviewHeaderView()
        self.tableview.tableFooterView = self.setTableviewFooterView()
        self.tableview.register(UINib(nibName: "LendEasy_mineCell", bundle: nil), forCellReuseIdentifier: "LendEasy_mineCell")
        
        let tableviewBgImageView = UIImageView(image: UIImage(named: "tableview_bg"))
        tableviewBgImageView.contentMode = .scaleToFill
        self.tableview.addSubview(tableviewBgImageView)
        tableviewBgImageView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.width.equalTo()(self.view.frame.size.width)
            make?.top.offset()(108)
            make?.bottom.offset()(0)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.firstSectionArr.count
        }else{
            return self.secondSectionArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mineCell : LendEasy_mineCell = tableView.dequeueReusableCell(withIdentifier: "LendEasy_mineCell") as! LendEasy_mineCell
        if indexPath.section == 0 {
            mineCell.mineTitleLabel.text = self.firstSectionArr[indexPath.row]
            mineCell.mineIcon.image = UIImage(named: self.firstSectionIconArr[indexPath.row])
        }else{
            mineCell.mineTitleLabel.text = self.secondSectionArr[indexPath.row]
            mineCell.mineIcon.image = UIImage(named: self.secondSectionIconArr[indexPath.row])
        }
        return mineCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc : LendEasy_ViewController = LendEasy_ViewController()
            vc.type = String(indexPath.row + 5)
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            if indexPath.row == 0 {
                LendEasy_Routes.routeURL(URL(string: "https://www.dancepeso.com/agreement"))
            }else if indexPath.row == 1{
                LendEasy_Routes.routeURL(URL(string: "https://www.dancepeso.com/presently_finished_screamed"))
            }else if indexPath.row == 2{
                LendEasy_Routes.routeURL(URL(string: "https://www.dancepeso.com/seemed_slippers_bobbing"))
            } else if indexPath.row == 3 {
                let aboutvc : LendEasy_aboutViewController = LendEasy_aboutViewController()
                self.navigationController?.pushViewController(aboutvc, animated: true)
                aboutvc.deleteAccountBlock = { str in
                    SVProgressHUD.showSuccess(withStatus: str)
                    self.navigationController?.popViewController(animated: true)
                    self.xl_sldeMenu.showRootViewController(animated: true)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        
        let headerLabel = UILabel()
        if section == 0 {
            headerLabel.text = "Orders"
        }else{
            headerLabel.text = "Setting"
        }
        headerLabel.font = UIFont.systemFont(ofSize: 14)
        headerLabel.textColor = UIColor(hex: "41485D")
        view.addSubview(headerLabel)
        headerLabel.mas_makeConstraints { make in
            make?.left.offset()(12)
            make?.top.offset()(18)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func setTableviewHeaderView() -> UIView {
        self.tableviewHeaderView = UIView()
        self.tableviewHeaderView.backgroundColor = UIColor.clear
        self.tableviewHeaderView.frame.size.height = 108
        
        self.headerIcon = UIImageView()
        self.headerIcon.image = UIImage(named: "personal_icon")
        self.tableviewHeaderView.addSubview(self.headerIcon)
        self.headerIcon.mas_makeConstraints { make in
            make?.left.offset()(20)
            make?.top.offset()(60)
            make?.width.equalTo()(24)
            make?.height.equalTo()(24)
        }
        
        self.telLabel = UILabel()
        self.telLabel.text = LendEasy_User.getUserPhoneNum()
        self.telLabel.textColor = UIColor(hex: "1F2642")
        self.telLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.tableviewHeaderView.addSubview(self.telLabel)
        self.telLabel.mas_makeConstraints { make in
            make?.left.equalTo()(self.headerIcon.mas_right)?.offset()(4)
            make?.centerY.equalTo()(self.headerIcon)
        }
        return self.tableviewHeaderView
    }

    func setTableviewFooterView() -> UIView {
        self.tableviewFooterView = UIView()
        self.tableviewFooterView.backgroundColor = UIColor.clear
        self.tableviewFooterView.frame.size.height = 90
        
        self.loginBtn = UIButton(type: .custom)
        self.loginBtn.setTitle("Logout", for: .normal)
        self.loginBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.loginBtn.setTitleColor(UIColor(hex: "FF5B60"), for: .normal)
        self.loginBtn.layer.cornerRadius = 8
        self.loginBtn.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        self.loginBtn.backgroundColor = UIColor.white
        self.tableviewFooterView.addSubview(self.loginBtn)
        self.loginBtn.mas_makeConstraints { make in
            make?.top.offset()(10)
            make?.left.offset()(12)
            make?.right.offset()(-12)
            make?.height.equalTo()(50)
        }
        return self.tableviewFooterView
    }
    
    @objc func toLoginAction(){
        let loginVC : LendEasy_LoginVC = LendEasy_LoginVC()
        self.present(loginVC, animated: true)
    }
    
    @objc func logoutAction(){
        let paramStr : String! = "disclosed=" + LendEasy_publicMethod.obtainAnyWord() + "&" + "proceeding=" + LendEasy_publicMethod.obtainAnyWord()
        LendEasy_NetAPI.sharedInstance.requestGetAPI(urlPath: "/there_rabbit_which", paramsString: paramStr, ifShowError: true, ifShowStyle: true) { model in
            if model.neatly == 0 {
                SVProgressHUD.showSuccess(withStatus: model.clearing)
                LendEasy_User.saveUserPhoneNum(phoneNumber: "")
                LendEasy_User.saveUserSessionId(sessionId: "")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LOGOUT"), object: nil)
                self.xl_sldeMenu.showRootViewController(animated: true)
            }
        }
    }
}
