//
//  LendEasy_HomeViewController.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/7.
//

import UIKit
import Kingfisher
class LendEasy_HomeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource, SDCycleScrollViewDelegate{
    var topView : UIImageView!
    var leftBtn : UIButton!
    var rightBtn : UIButton!
    var logoIcon : UIImageView!
    var appNameLabel : UILabel!
    var tableview : UITableView!
    var processBgImageView : UIImageView!
    var amountIntroLabel : UILabel!
    var amountLabel : JQScrollNumberLabel!
    var rateIntoLabel : UILabel!
    var scrollInfoView : UIView!
    var scrollLabel : AdScrollLabelView!
    var button : UIButton!
    var productModel : productInfoModel?
    var firstTime : Bool = false
    var imageUrlArr = [String]()
    var linkUrlArr = [String]()
    var cycleScrollView : SDCycleScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "F5F7FB")

        NotificationCenter.default.addObserver(self, selector: #selector(todoUploadInfoAction), name: NSNotification.Name(rawValue: "TODOUPLOADIINFO"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshHomeInfo), name: NSNotification.Name(rawValue: "LOGOUT"), object: nil)

    }
    
    @objc func todoUploadInfoAction(){
//        if firstTime == true {
//            return
//        }
//        firstTime = true
        LendEasy_uploadInfoTool.uploadHomeInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        getLendEasyProductInfo()
    }
    
    @objc func refreshHomeInfo(){
        self.getLendEasyProductInfo()
    }

    
    func getLendEasyProductInfo(){
        let paramStr : String! = "skins=" + LendEasy_publicMethod.obtainAnyWord() + "&" + "bundle=" + LendEasy_publicMethod.obtainAnyWord()
        LendEasy_NetAPI.sharedInstance.requestGetAPI(urlPath: "/terrible_themselves_apiece", paramsString: paramStr, ifShowError: true, ifShowStyle: true) { model in
            if model.neatly == 0 {
                self.productModel = productInfoModel(jsondata: model.crows!)
                self.setUpStyleView()
                self.tableview.mj_header?.endRefreshing()
            }

        }
    }
    
    func setUpStyleView(){
        for subview in self.view.subviews {
            subview.removeFromSuperview()
        }
        
        self.topView = UIImageView()
        self.topView.isHidden = true
        self.topView.image = UIImage(named: "home_top")
        self.view.addSubview(self.topView)
        self.topView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.top.offset()(0)
            make?.right.offset()(0)
        }
        
        self.tableview = UITableView.init()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.backgroundColor = UIColor.clear
        self.tableview.showsVerticalScrollIndicator = false
        self.tableview.showsHorizontalScrollIndicator = false
        self.tableview.isScrollEnabled = true
        self.tableview.separatorStyle = .none
        self.tableview.register(UINib(nibName: "LendEasy_HomeProductCell", bundle: nil), forCellReuseIdentifier: "LendEasy_HomeProductCell")
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
        
        if self.productModel?.pantry?.sooner?.count != 0 {
            self.view.backgroundColor = UIColor(hex: "FCD465")
            self.tableview.tableHeaderView = tableHeaderView
            self.topView.isHidden = true
        }else{
            self.view.backgroundColor = UIColor(hex: "F5F7FB")
            self.tableview.tableHeaderView = nil
            self.tableview.tableHeaderView = tableHeader01View
            self.topView.isHidden = false
        }
        
        let refreshHeader : LendEasy_RefreshHeader = LendEasy_RefreshHeader {
            self.getLendEasyProductInfo()
        }
        refreshHeader.tintColor = UIColor.white
        refreshHeader.stateLabel?.textColor = UIColor.clear;
        refreshHeader.loadingView?.style = .white
        self.tableview.mj_header = refreshHeader;
    }
    
    @objc func leftClickAction(){
        if LendEasy_User.checkIsLogin(topViewController: self) == false {
            return
        }
        self.xl_sldeMenu.showLeftViewController(animated: true)

    }
    
    @objc func rightClickAction(){
        if LendEasy_User.checkIsLogin(topViewController: self) == false {
            return
        }
        let vc : LendEasy_ViewController = LendEasy_ViewController()
        vc.type = "5"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.productModel?.pantry?.sooner?.count != 0 {
            return 0
        }else{
            return self.productModel?.tearing?.sliceArr.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model : tearinSliceModel = (self.productModel?.tearing?.sliceArr[indexPath.row])!
        let cell : LendEasy_HomeProductCell = tableView.dequeueReusableCell(withIdentifier: "LendEasy_HomeProductCell") as! LendEasy_HomeProductCell
        cell.operationBtn.setTitle(model.smoking, for: .normal)
        cell.firstTitleLabel.text = model.jabbed ?? ""
        cell.firstResultLabel.text = model.potato ?? ""
        cell.secondTitleLabel.text = model.loanTermText ?? ""
        cell.secondResultLabel.text = model.beforehand ?? ""
        cell.productIcon.kf.setImage(with: URL(string: model.hoping ?? ""))
        cell.productLabel.text = model.stifled ?? ""
        if model.thisnx == "1"{
            cell.operationBtn.backgroundColor = UIColor(hex: "18B38A")
        }else if model.thisnx == "2"{
            cell.operationBtn.backgroundColor = UIColor(hex: "FF5A00")
        }else if model.thisnx == "3"{
            cell.operationBtn.backgroundColor = UIColor(hex: "C5CAD5")
        }
        cell.operationBtn.tag = indexPath.row
        cell.operationBtn.addTarget(self, action: #selector(OperationAction), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    lazy var tableHeader01View : UIView = {
        let headerView = UIView()
        let titleLabel : UILabel = UILabel()
        titleLabel.text = "Easy Peso"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headerView.addSubview(titleLabel)
        titleLabel.mas_makeConstraints { make in
            make?.top.offset()(CGFloat(k_StatusBarHeight + 10))
            make?.centerX.equalTo()(headerView)
        }
        
        self.leftBtn = UIButton(type: .custom)
        self.leftBtn.setImage(UIImage(named: "home_leftIcon"), for: .normal)
        headerView.addSubview(self.leftBtn)
        self.leftBtn.mas_makeConstraints { make in
            make?.centerY.equalTo()(titleLabel)
            make?.left.offset()(20)
            make?.width.equalTo()(24)
            make?.height.equalTo()(24)
        }
        self.leftBtn.addTarget(self, action: #selector(leftClickAction), for: .touchUpInside)
        
        self.rightBtn = UIButton(type: .custom)
        self.rightBtn.setImage(UIImage(named: "home_rightIcon"), for: .normal)
        headerView.addSubview(self.rightBtn)
        self.rightBtn.mas_makeConstraints { make in
            make?.centerY.equalTo()(titleLabel)
            make?.right.offset()(-20)
            make?.width.equalTo()(24)
            make?.height.equalTo()(24)
        }
        self.rightBtn.addTarget(self, action: #selector(rightClickAction), for: .touchUpInside)
        
        if self.productModel?.forthcoming?.sooner?.count ?? 0 > 0 {
            for model : forthcomingSliceModel in (self.productModel?.forthcoming?.sliceArr)!{
                self.imageUrlArr.append(model.astonishment ?? "")
                self.linkUrlArr.append(model.recklessly ?? "")
            }
            self.cycleScrollView = SDCycleScrollView(frame: CGRect(x: 16, y: k_StatusBarHeight + 70, width: Int(SCREEN_WIDTH) - 32, height: Int((SCREEN_WIDTH) - 32)*184/686), delegate: self, placeholderImage: UIImage(named: ""))
            self.cycleScrollView.delegate = self
            self.cycleScrollView.layer.cornerRadius = 8.0
            self.cycleScrollView.clipsToBounds = true
            self.cycleScrollView.autoScrollTimeInterval = 5.0
            self.cycleScrollView.backgroundColor = UIColor.white
            self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone
            self.cycleScrollView.imageURLStringsGroup = self.imageUrlArr
            headerView.addSubview(self.cycleScrollView)
            if self.productModel?.cloud?.sooner?.count ?? 0 > 0 {
                headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 113 + 60 + CGFloat((SCREEN_WIDTH) - 32)*184/686 + 10)
                self.scrollInfoView = UIView()
                self.scrollInfoView.backgroundColor = UIColor.white
                self.scrollInfoView.layer.cornerRadius = 8
                self.scrollInfoView.clipsToBounds = true
                headerView.addSubview(self.scrollInfoView)
                self.scrollInfoView.mas_makeConstraints { make in
                    make?.left.offset()(16)
                    make?.top.equalTo()(self.cycleScrollView.mas_bottom)?.offset()(10)
                    make?.height.equalTo()(60)
                    make?.right.offset()(-16)
                }

                let notificationIcon = UIImageView()
                notificationIcon.image = UIImage(named: "horn_icon")
                self.scrollInfoView.addSubview(notificationIcon)
                notificationIcon.mas_makeConstraints { make in
                    make?.left.offset()(12)
                    make?.centerY.equalTo()(self.scrollInfoView)
                    make?.height.equalTo()(20)
                    make?.width.equalTo()(20)
                }

                let scrollLabelView = AdScrollLabelView.init(frame: CGRect.init(x: 40, y: 0, width: SCREEN_WIDTH - 32 - 40, height: 60))
                scrollLabelView.ifNumbers = true
                scrollLabelView.backgroundColor = .clear
                scrollLabelView.adTextAlignment = .left
                scrollLabelView.isHiiddenAdImage = true
                scrollLabelView.adLabelClick = {index in
                    print(index)
                }
                var array = [String]()
                for model : cloudSliceModel in (self.productModel?.cloud?.sliceArr)!{
                    array.append(model.clamoring ?? "")
                }
                scrollLabelView.beginScroll(textArray: array)
                self.scrollInfoView.addSubview(scrollLabelView)
                scrollLabelView.adLabelClick = { index in
                    let currentModel : cloudSliceModel = (self.productModel?.cloud?.sliceArr[index])!
                    LendEasy_Routes.openURL(currentModel.recklessly ?? "")
                }
            }else{
                headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 113 + CGFloat((SCREEN_WIDTH) - 32)*184/686 + 10)
            }
        }else{
            if self.productModel?.cloud?.sooner?.count ?? 0 > 0 {
                headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 113+40)
            }else{
                headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 113)
            }
        }
        
        return headerView
    }()
    
    
    lazy var tableHeaderView : UIView = {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        let imageHeight = SCREEN_WIDTH*1062/750 + SCREEN_WIDTH*843/748 + 128
        headerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: imageHeight)
        
        let topBgImageView : UIImageView = UIImageView()
        topBgImageView.image = UIImage(named: "home_top_bg")
        headerView.addSubview(topBgImageView)
        topBgImageView.mas_makeConstraints { make in
            make?.top.offset()(0)
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.height.equalTo()(SCREEN_WIDTH*1062/750)
        }
        
        let mediumView = UIView()
        mediumView.backgroundColor = UIColor(hex:"E27C30")
        headerView.addSubview(mediumView)
        mediumView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.equalTo()(topBgImageView.mas_bottom)?.offset()(0)
            make?.height.equalTo()(128)
        }
        
        let bottomBgImageView : UIImageView = UIImageView()
        bottomBgImageView.image = UIImage(named: "home_bottom_bg")
        headerView.addSubview(bottomBgImageView)
        bottomBgImageView.mas_makeConstraints { make in
            make?.top.equalTo()(mediumView.mas_bottom)?.offset()(0)
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.height.equalTo()(SCREEN_WIDTH*843/748)
        }
        
        self.leftBtn = UIButton(type: .custom)
        self.leftBtn.setImage(UIImage(named: "home_leftIcon"), for: .normal)
        headerView.addSubview(self.leftBtn)
        self.leftBtn.mas_makeConstraints { make in
            make?.top.equalTo()(topBgImageView.mas_top)?.offset()(70/531*(SCREEN_WIDTH*1062/750))
            make?.left.equalTo()(topBgImageView.mas_left)?.offset()(32)
            make?.width.equalTo()(24)
            make?.height.equalTo()(24)
        }
        self.leftBtn.addTarget(self, action: #selector(leftClickAction), for: .touchUpInside)
        
        self.rightBtn = UIButton(type: .custom)
        self.rightBtn.setImage(UIImage(named: "home_rightIcon"), for: .normal)
        headerView.addSubview(self.rightBtn)
        self.rightBtn.mas_makeConstraints { make in
            make?.top.equalTo()(topBgImageView.mas_top)?.offset()(70/531*(SCREEN_WIDTH*1062/750))
            make?.right.equalTo()(topBgImageView.mas_right)?.offset()(-32)
            make?.width.equalTo()(24)
            make?.height.equalTo()(24)
        }
        self.rightBtn.addTarget(self, action: #selector(rightClickAction), for: .touchUpInside)
        
        self.scrollInfoView = UIView()
        self.scrollInfoView.backgroundColor = UIColor.clear
//        self.scrollInfoView.layer.cornerRadius = 20
        headerView.addSubview(self.scrollInfoView)
        self.scrollInfoView.mas_makeConstraints { make in
            make?.left.equalTo()(self.leftBtn.mas_right)?.offset()(12)
            make?.top.equalTo()(self.leftBtn.mas_bottom)?.offset()(60/531*(SCREEN_WIDTH*1062/750))
            make?.height.equalTo()(36)
            make?.right.equalTo()(self.rightBtn.mas_left)?.offset()(-6)
        }

        let notificationIcon = UIImageView()
        notificationIcon.image = UIImage(named: "horn_icon")
        self.scrollInfoView.addSubview(notificationIcon)
        notificationIcon.mas_makeConstraints { make in
            make?.left.offset()(12)
            make?.centerY.equalTo()(self.scrollInfoView)
            make?.height.equalTo()(20)
            make?.width.equalTo()(20)
        }

        let scrollLabelView = AdScrollLabelView.init(frame: CGRect.init(x: 40, y: 0, width: SCREEN_WIDTH - 150 - 24, height: 36))
        scrollLabelView.backgroundColor = .clear
        scrollLabelView.adTextAlignment = .left
        scrollLabelView.isHiiddenAdImage = true
        scrollLabelView.adLabelClick = {index in
            print(index)
        }
        var array = [String]()
        for model : cloudSliceModel in (self.productModel?.cloud?.sliceArr)!{
            array.append(model.clamoring ?? "")
        }
        scrollLabelView.beginScroll(textArray: array)
        self.scrollInfoView.addSubview(scrollLabelView)
        scrollLabelView.adLabelClick = { index in
            let currentModel : cloudSliceModel = (self.productModel?.cloud?.sliceArr[index])!
            LendEasy_Routes.openURL(currentModel.recklessly ?? "")
        }
        
        self.amountIntroLabel = UILabel()
        self.amountIntroLabel.text = self.productModel?.pantry?.slice?.jabbed
        self.amountIntroLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.amountIntroLabel.textColor = UIColor(hex: "1F2642")
        headerView.addSubview(self.amountIntroLabel)
        self.amountIntroLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.scrollInfoView.mas_bottom)?.offset()(44)
            make?.centerX.equalTo()(headerView)
        }
        
        let numberBlackBgView : UIView = UIView()
        numberBlackBgView.backgroundColor = UIColor(hex:"0C0C0C")
        numberBlackBgView.layer.cornerRadius = 4.0
        numberBlackBgView.clipsToBounds = true
        headerView.addSubview(numberBlackBgView)
        numberBlackBgView.mas_makeConstraints { make in
            make?.height.equalTo()(50)
            make?.centerX.equalTo()(headerView)
            make?.top.equalTo()(self.amountIntroLabel.mas_bottom)?.offset()(20)
        }
        
        let hbMarkerLabel = UILabel()
        hbMarkerLabel.text = "₱"
        hbMarkerLabel.textColor = UIColor.white
        hbMarkerLabel.font = UIFont(name: "DIN Alternate Bold", size: 40)
        numberBlackBgView.addSubview(hbMarkerLabel)
        hbMarkerLabel.mas_makeConstraints { make in
            make?.left.offset()(20)
            make?.width.equalTo()(30)
            make?.centerY.equalTo()(numberBlackBgView)
        }

        self.amountLabel = JQScrollNumberLabel(number: NSNumber(value: 1), font: UIFont.boldSystemFont(ofSize: 40), textColor: UIColor.white)
        self.amountLabel.frame = CGRectMake(55, 0, self.amountLabel.frame.size.width, self.amountLabel.frame.size.height);
        if let myInteger = Int((self.productModel?.pantry?.slice?.potato)!) {
            let myNumber = NSNumber(value:myInteger)
            self.amountLabel.change(to: myNumber, animated: true)
        }
        numberBlackBgView.addSubview(self.amountLabel)
        
        numberBlackBgView.mas_remakeConstraints { make in
            make?.height.equalTo()(50)
            make?.centerX.equalTo()(headerView)
            make?.top.equalTo()(self.amountIntroLabel.mas_bottom)?.offset()(20)
            make?.width.equalTo()(self.amountLabel.frame.size.width + 40 + 45)
        }

        self.rateIntoLabel = UILabel()
        self.rateIntoLabel.textAlignment = .center
        self.rateIntoLabel.font = UIFont.systemFont(ofSize: 14)
        self.rateIntoLabel.numberOfLines = 0
        self.rateIntoLabel.textColor = UIColor(hex: "111A34")
        let rateStr = (self.productModel?.pantry?.slice?.sobbed ?? "") + "\n" + (self.productModel?.pantry?.slice?.helplessly ?? "")
        let attr = NSMutableAttributedString(string: rateStr)
        if self.productModel?.pantry?.slice?.helplessly?.count ?? 0 > 0 {
            let range : Range = rateStr.range(of: (self.productModel?.pantry?.slice?.helplessly ?? ""))!
            attr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: "FF5A00"), range: NSRange(range, in: rateStr))
            self.rateIntoLabel.attributedText = attr
        }
        headerView.addSubview(self.rateIntoLabel)
        self.rateIntoLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.amountLabel.mas_bottom)?.offset()(20)
            make?.centerX.equalTo()(headerView)
        }

//        self.logoIcon = UIImageView()
//        self.logoIcon.image = UIImage(named: "home_icon_white")
//        headerView.addSubview(self.logoIcon)
//        self.logoIcon.mas_makeConstraints { make in
//            make?.centerX.equalTo()(headerView)
//            make?.bottom.equalTo()(bottomBgImageView.mas_bottom)?.offset()(-75)
//        }
//        
        self.appNameLabel = UILabel()
        self.appNameLabel.text = "@2023 DANCEPESO LENDING CORPORATION"
        self.appNameLabel.textColor = UIColor(hex:"C4A589")
        self.appNameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        headerView.addSubview(self.appNameLabel)
        self.appNameLabel.mas_makeConstraints { make in
            make?.bottom.equalTo()(bottomBgImageView.mas_bottom)?.offset()(-26)
            make?.centerX.equalTo()(headerView)
        }
        
        self.button = UIButton(type: .custom)
        self.button.setTitle(self.productModel?.pantry?.slice?.smoking ?? "", for: .normal)
        self.button.layer.cornerRadius = 25
        self.button.setTitleColor(UIColor.white, for: .normal)
        self.button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        self.button.setBackgroundImage(UIImage(named: "home_btn_bg"), for: .normal)
        mediumView.addSubview(self.button)
        self.button.mas_makeConstraints { make in
            make?.left.offset()(16)
            make?.right.offset()(-16)
            make?.height.equalTo()(50)
            make?.top.offset()(15)
        }
        self.button.addTarget(self, action: #selector(applyAction), for: .touchUpInside)
        
        let tipLabel = UILabel()
        tipLabel.numberOfLines = 0
        tipLabel.textColor = UIColor.white
        tipLabel.font = UIFont.systemFont(ofSize: 12)
        let tipStr = "Kindly review the Privacy Agreement and Loan Terms before proceeding with your application."
        let tipAttr = NSMutableAttributedString(string: tipStr)
        let range01 : Range = tipStr.range(of: "Privacy Agreement and Loan Terms")!
        tipAttr.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 12), range: NSRange(range01, in: tipStr))
        tipLabel.attributedText = tipAttr
        mediumView.addSubview(tipLabel)
        tipLabel.mas_makeConstraints { make in
            make?.left.offset()(32)
            make?.right.offset()(-32)
            make?.top.equalTo()(self.button.mas_bottom)?.offset()(10)
        }
        
        tipLabel.isUserInteractionEnabled = true
        let tipLabelTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(checkAgreementAction))
        tipLabel.addGestureRecognizer(tipLabelTap)
        
        return headerView
    }()
    
    lazy var tableFooterView : UIView = {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        headerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 300)
        
        
        return headerView
    }()
    
    @objc func checkAgreementAction(){
        LendEasy_Routes.routeURL(URL(string: "https://www.dancepeso.com/agreement"))
    }
    
    @objc func applyAction(){
        let params : [String:Any] = ["stories":self.productModel?.pantry?.slice?.mouthful ?? "","mortification":LendEasy_publicMethod.obtainAnyWord(),"specimens":LendEasy_publicMethod.obtainAnyWord()]
        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/voice_splash_after",  paramsDictionary: params, ifShowError: true, ifShowStyle: true) { model in
            if model.neatly == 0 {
                let model : applyResultModel = applyResultModel(jsondata: model.crows!)
                if model.recklessly?.count ?? 0 > 0 {
                    LendEasy_Routes.routeURL(URL(string: model.recklessly!))
                }else{
                    let vc : LendEasy_VertifyProcessViewController = LendEasy_VertifyProcessViewController()
                    vc.loadId = self.productModel?.pantry?.slice?.mouthful ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        let linkUrl : String = self.linkUrlArr[index]
        if linkUrl.range(of: "ld.easy/") != nil {
            LendEasy_Routes.routeURL(URL(string: "ey://" + linkUrl))
        }else{
            LendEasy_Routes.routeURL(URL(string: linkUrl))
        }
    }
    
    @objc func OperationAction(btn : UIButton){
        let tag = btn.tag
        let model : tearinSliceModel = (self.productModel?.tearing?.sliceArr[tag])!
        let params : [String:Any] = ["stories":model.mouthful ?? "","mortification":LendEasy_publicMethod.obtainAnyWord(),"specimens":LendEasy_publicMethod.obtainAnyWord()]
        LendEasy_NetAPI.sharedInstance.requestPostAPI(urlPath: "/voice_splash_after",  paramsDictionary: params, ifShowError: true, ifShowStyle: true) { model in
            if model.neatly == 0 {
                let model : applyResultModel = applyResultModel(jsondata: model.crows!)
                if model.recklessly?.count ?? 0 > 0 {
                    LendEasy_Routes.routeURL(URL(string: model.recklessly!))
                }
            }
        }
    }
}
