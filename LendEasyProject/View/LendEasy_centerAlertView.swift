//
//  LendEasy_centerAlertView.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/24.
//

import UIKit

class LendEasy_centerAlertView: UIView {
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var operationBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    var cancelBlock:(()->())?
    var operationBlock:(()->())?
    override func awakeFromNib() {
        self.cancelBtn.layer.cornerRadius = 12
        self.operationBtn.layer.cornerRadius = 12
        self.contentView.layer.cornerRadius = 12
        
        self.cancelBtn.layer.borderWidth = 1.0
        self.cancelBtn.layer.borderColor = UIColor(hex: "E2E4EA").cgColor
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.removeFromSuperview()
        self.cancelBlock?()
    }
    
    @IBAction func operationBlock(_ sender: Any) {
        self.removeFromSuperview()
        self.operationBlock?()
    }
}
