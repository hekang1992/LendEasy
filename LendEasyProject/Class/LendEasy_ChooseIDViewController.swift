//
//  LendEasy_ChooseIDViewController.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/11.
//

import UIKit

class LendEasy_ChooseIDViewController: UIViewController {
    @IBOutlet weak var top_titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollviewWIdth: NSLayoutConstraint!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var otherView: UIView!
    @IBOutlet weak var recommendViewHeight: NSLayoutConstraint!
    @IBOutlet weak var otherViewHeight: NSLayoutConstraint!
    @IBOutlet weak var recommendLabelWIdth: NSLayoutConstraint!
    @IBOutlet weak var otherLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var recommendLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    var loadId : String!
    var model : identifyModel!
    var selectView : LendEasy_chooseIDView!
    var titleStr : String?
    var enterTime : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.isHidden = true
        self.scrollviewWIdth.constant = SCREEN_WIDTH - 32
        self.contentView.layer.cornerRadius = 8
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        
        self.recommendLabelWIdth.constant = SCREEN_WIDTH - 32
        self.otherLabelWidth.constant = SCREEN_WIDTH - 32
        
        self.enterTime = LendEasy_publicMethod.getCurrentTime()

        setUpStyleView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func setUpStyleView(){
        self.scrollView.isHidden = false

        var firstIDArr : [String] = []
        if self.model.oozing!.count > 0 {
            firstIDArr = self.model.oozing![0].rawValue as! [String]
        }
        if firstIDArr.count > 0 {
            for i in 0...firstIDArr.count - 1 {
                let idStr : String = firstIDArr[i]
                let viewArr = Bundle.main.loadNibNamed("LendEasy_chooseIDView", owner: nil)
                let recommendChooseIDView : LendEasy_chooseIDView = viewArr![0] as! LendEasy_chooseIDView
                recommendChooseIDView.clickBtn.tag = i
                recommendChooseIDView.IdNameLabel.text = idStr
                self.recommendView.addSubview(recommendChooseIDView)
                recommendChooseIDView.mas_makeConstraints { make in
                    make?.left.offset()(16)
                    make?.top.offset()(CGFloat(i*50))
                    make?.right.offset()(-16)
                    make?.height.equalTo()(50)
                }
                
                
                if i == 0 {
                    recommendChooseIDView.rightIcon.isHidden = false
                    self.selectView = recommendChooseIDView
                }else{
                    recommendChooseIDView.rightIcon.isHidden = true
                }
                
                if i == firstIDArr.count - 1 {
                    recommendChooseIDView.lineView.isHidden = true
                }else{
                    recommendChooseIDView.lineView.isHidden = false
                }
                recommendChooseIDView.chooseIDBlock = { index in
                    print("----- %d",index)
                    self.selectView.rightIcon.isHidden = true
                    recommendChooseIDView.rightIcon.isHidden = false
                    self.selectView = recommendChooseIDView
                                        
                    let vertifyIdentifyVC : LendEasy_VertifyIdentifyViewController = LendEasy_VertifyIdentifyViewController()
                    vertifyIdentifyVC.titleStr = self.titleStr
                    vertifyIdentifyVC.idStr = firstIDArr[index]
                    vertifyIdentifyVC.loadId = self.loadId
                    vertifyIdentifyVC.model = self.model
                    self.navigationController?.pushViewController(vertifyIdentifyVC, animated: true)
                    
                    LendEasy_addPointEventTool().addPointEvent(loanID: self.loadId, jollity: "2", firstTime: self.enterTime ?? "", secondTime: LendEasy_publicMethod.getCurrentTime())
                }
            }
        }
        
        self.recommendViewHeight.constant = CGFloat(50 * firstIDArr.count)
        self.recommendLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH - 32, 60)
        self.recommendLabel.layer.mask = self.configRectCorner(view: self.recommendLabel, corner: [.topLeft, .topRight], radii: CGSize(width: 8, height: 8))
        self.recommendView.frame = CGRect(x: 0, y: 60, width: SCREEN_WIDTH - 32, height: CGFloat(50*firstIDArr.count))
        self.recommendView.layer.mask = self.configRectCorner(view: self.recommendView, corner: [.bottomLeft, .bottomRight], radii: CGSize(width: 8, height: 8))
        
        
        var secondIDArr : [String] = []
        if self.model.oozing!.count > 1 {
            secondIDArr = self.model.oozing![1].rawValue as! [String]
        }
        if secondIDArr.count > 0 {
            for j in 0...secondIDArr.count - 1{
                let idStr : String = secondIDArr[j]
                let viewArr = Bundle.main.loadNibNamed("LendEasy_chooseIDView", owner: nil)
                let recommendChooseIDView : LendEasy_chooseIDView = viewArr![0] as! LendEasy_chooseIDView
                recommendChooseIDView.tag = j
                recommendChooseIDView.IdNameLabel.text = idStr
                self.otherView.addSubview(recommendChooseIDView)
                recommendChooseIDView.mas_makeConstraints { make in
                    make?.left.offset()(16)
                    make?.top.offset()(CGFloat(j*50))
                    make?.right.offset()(-16)
                    make?.height.equalTo()(50)
                }
                recommendChooseIDView.rightIcon.isHidden = true
                if j ==  secondIDArr.count - 1{
                    recommendChooseIDView.lineView.isHidden = true
                }else{
                    recommendChooseIDView.lineView.isHidden = false
                }
                recommendChooseIDView.chooseIDBlock = { index in
                    print("----- %d",index)
                    self.selectView.rightIcon.isHidden = true
                    recommendChooseIDView.rightIcon.isHidden = false
                    self.selectView = recommendChooseIDView
                    
                    let vertifyIdentifyVC : LendEasy_VertifyIdentifyViewController = LendEasy_VertifyIdentifyViewController()
                    vertifyIdentifyVC.titleStr = self.titleStr
                    vertifyIdentifyVC.idStr = secondIDArr[index]
                    vertifyIdentifyVC.loadId = self.loadId
                    vertifyIdentifyVC.model = self.model
                    self.navigationController?.pushViewController(vertifyIdentifyVC, animated: true)
                    
                    LendEasy_addPointEventTool().addPointEvent(loanID: self.loadId, jollity: "2", firstTime: self.enterTime ?? "", secondTime: LendEasy_publicMethod.getCurrentTime())
                }
            }
        }else{
            self.otherLabel.isHidden = true
        }
        self.otherViewHeight.constant = CGFloat(50 * secondIDArr.count)
        self.contentHeight.constant = CGFloat(firstIDArr.count + secondIDArr.count)*50 + 2*60 + 20
        self.otherLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH - 32, 60)
        self.otherLabel.layer.mask = self.configRectCorner(view: self.otherLabel, corner: [.topLeft, .topRight], radii: CGSize(width: 8, height: 8))
        self.otherView.frame = CGRect(x: 0, y: 60, width: SCREEN_WIDTH - 32, height: CGFloat(50 * secondIDArr.count))
        self.otherView.layer.mask = self.configRectCorner(view: self.otherView, corner: [.bottomLeft, .bottomRight], radii: CGSize(width: 8, height: 8))
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configRectCorner(view: UIView, corner: UIRectCorner, radii: CGSize) -> CALayer {
         let maskPath = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: corner, cornerRadii: radii)
         let maskLayer = CAShapeLayer.init()
         maskLayer.frame = view.bounds
         maskLayer.path = maskPath.cgPath
         return maskLayer
     }
}
