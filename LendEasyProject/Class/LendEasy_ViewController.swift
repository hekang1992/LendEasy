//
//  LendEasy_ViewController.swift
//  LendEasyProject
//
//  Created by Apple on 2023/11/7.
//

import UIKit

@objcMembers
class LendEasy_ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var type : String! //4 all 5 finish 6 repay 7 repaying 8 fail
    var tableview : UITableView!
    var ordermodel : orderModel?
    var orderType : String!
    var noOrderIcon : UIImageView?
    var noOrderLabel : UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "F3F5F7")
        if type == "4"{
            self.title = ""
        }else if type == "5" {
            self.orderType = "6"
            self.title = "Pending repayment"
        }else if type == "6" {
            self.orderType = "8"
            self.title = "Payment failed"
        }else if type == "7" {
            self.orderType = "7"
            self.title = "In progress"
        }else{
            self.orderType = "5"
            self.title = "Order completed"
        }
        self.setUpStyleView()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.getOrderListInfo()
    }
    
    func setUpStyleView(){
        self.noOrderIcon = UIImageView()
        self.noOrderIcon?.image = UIImage(named: "noOrderIcon")
        self.noOrderIcon?.isHidden = true
        self.view.addSubview(self.noOrderIcon!)
        self.noOrderIcon?.mas_makeConstraints({ make in
            make?.centerX.equalTo()(self.view)
            make?.centerY.equalTo()(self.view)?.offset()(-100)
        })
        
        self.noOrderLabel = UILabel()
        self.noOrderLabel?.text = "No orders"
        self.noOrderLabel?.isHidden = true
        self.noOrderLabel?.textColor = UIColor(hex: "858B9C")
        self.noOrderLabel?.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(self.noOrderLabel!)
        self.noOrderLabel?.mas_makeConstraints({ make in
            make?.top.equalTo()(self.noOrderIcon?.mas_bottom)?.offset()(20)
            make?.centerX.equalTo()(self.noOrderIcon)
        })
        
        self.tableview = UITableView.init()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.backgroundColor = UIColor.clear
        self.tableview.showsVerticalScrollIndicator = false
        self.tableview.showsHorizontalScrollIndicator = false
        self.tableview.isScrollEnabled = true
        self.tableview.separatorStyle = .none
        self.tableview.register(UINib(nibName: "LendEasy_OrderCell", bundle: nil), forCellReuseIdentifier: "LendEasy_OrderCell")
        self.view.addSubview(self.tableview)
        self.tableview.mas_makeConstraints { make in
            make?.top.offset()(20)
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
        
        let refreshHeader : LendEasy_RefreshHeader = LendEasy_RefreshHeader {
            
        }
        refreshHeader.tintColor = UIColor.white
        refreshHeader.stateLabel?.textColor = UIColor.clear;
        refreshHeader.loadingView?.style = .white
        self.tableview.mj_header = refreshHeader;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ordermodel?.orderTearingArr.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model : orderTearingModel = (self.ordermodel?.orderTearingArr[indexPath.row])!
        let cell : LendEasy_OrderCell = tableView.dequeueReusableCell(withIdentifier: "LendEasy_OrderCell") as! LendEasy_OrderCell
        cell.productNameLabel.text = model.stifled ?? ""
        cell.orderStateLabel.text = model.smoking ?? ""
        cell.daterTitleLabel.text = "Loan Date："
        cell.daterLabel.text = model.shout ?? ""
        cell.firstTitleLabel.text = "Loan Amount"
        cell.firstResultLabel.text = model.wedding ?? ""
        cell.secondTitleLabel.text = "Repayment Date"
        if model.suddenly?.count == 0 {
            cell.secondResultLabel.text = "--/--/----"
        }else{
            cell.secondResultLabel.text = model.suddenly ?? "--/--/----"
        }
        if orderType == "5" {
            cell.orderStateLabel.textColor = UIColor(hex: "18B38A")
        }else if orderType == "6" {
            cell.orderStateLabel.textColor = UIColor(hex: "FF5A00")
        }else if orderType == "7" {
            cell.orderStateLabel.textColor = UIColor(hex: "18B38A")
        }else{
            cell.orderStateLabel.textColor = UIColor.red
        }
        
        if self.orderType == "8"{
            cell.tipLabel.isHidden = false
            cell.changeBtn.isHidden = false
            cell.changeBtn.tag = indexPath.row
            cell.changeBtn.addTarget(self, action: #selector(changeStateAction), for: .touchUpInside)
        }else{
            cell.tipLabel.isHidden = true
            cell.changeBtn.isHidden = true
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model : orderTearingModel = (self.ordermodel?.orderTearingArr[indexPath.row])!
        LendEasy_Routes.routeURL(URL(string: model.snippings ?? ""))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.orderType == "8"{
            return 215
        }else{
            return 170
        }
    }
    
    @objc func changeStateAction(btn : UIButton){
        let model : orderTearingModel = (self.ordermodel?.orderTearingArr[btn.tag])!
        LendEasy_Routes.routeURL(URL(string: model.goody ?? ""))
    }
    
    func getOrderListInfo(){
        let params : [String:Any] = ["horsie":self.orderType!,"cheerfully":"1","longed":"9999"]
        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/browand_screamed_fresh",  paramsDictionary: params, ifShowError: true, ifShowStyle: true) { model in
            if model.neatly == 0 {
                if model.crows != nil {
                    self.ordermodel = orderModel(jsondata: model.crows!)
                    self.tableview.reloadData()
                    if self.ordermodel?.orderTearingArr.count == 0 {
                        self.noOrderIcon?.isHidden = false
                        self.noOrderLabel?.isHidden = false
                    }else{
                        self.noOrderIcon?.isHidden = true
                        self.noOrderLabel?.isHidden = true
                    }
                }
            }
            
            self.tableview.mj_header?.endRefreshing()

        }
    }
}
