//
//  LendEasy_cardExampleView.swift
//  LendEasyProject
//
//  Created by Apple on 2023/11/1.
//

import UIKit

class LendEasy_cardExampleView: UIView {
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomviewHeightContant: NSLayoutConstraint!
    @IBOutlet weak var firstOperationBtn: UIButton!
    @IBOutlet weak var secondOperationBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var rightExampleIcon: UIImageView!
    @IBOutlet weak var thirdErrorExampleIcon: UIImageView!
    @IBOutlet weak var firstErrorExampleIcon: UIImageView!
    @IBOutlet weak var secondErrorExampleIcon: UIImageView!
    @IBOutlet weak var widthContant: NSLayoutConstraint!
    var firstOperationBlock:(()->())?
    var secondOperationBlock:(()->())?
    override func awakeFromNib() {
        self.bottomView.layer.cornerRadius = 12
        self.topView.layer.cornerRadius = 12
        self.bottomView.clipsToBounds = true
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBAction func firstOperationAction(_ sender: Any) {
        self.removeFromSuperview()
        firstOperationBlock?()
    }
    
    @IBAction func secondOperationAction(_ sender: Any) {
        self.removeFromSuperview()
        secondOperationBlock?()
    }
}
