//
//  LendEasy_workInfoItemView.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/12.
//

import UIKit

class LendEasy_workInfoItemView: UIView {
    @IBOutlet weak var fillTitleLabel: UILabel!
    @IBOutlet weak var fillView: UIView!
    @IBOutlet weak var fillTextField: UITextField!
    @IBOutlet weak var downArrowIcon: UIImageView!
    @IBOutlet weak var fillTextFieldTrailConstant: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.fillView.layer.borderColor = UIColor(hex: "E2E4EA").cgColor
        self.fillView.layer.borderWidth = 1.0
        self.fillView.layer.cornerRadius = 25
        self.fillTextField.placeHolderColor = UIColor(hex: "C5CAD5")
        
        self.fillTextField.setupToolBar()
        self.fillTextField.showToolBar()
    }
}
