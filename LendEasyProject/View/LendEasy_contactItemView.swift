//
//  LendEasy_contactItemView.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/12.
//

import UIKit

class LendEasy_contactItemView: UIView {
    @IBOutlet weak var emergencyTitleLabel: UILabel!
    @IBOutlet weak var relationshipTitleLabel: UILabel!
    @IBOutlet weak var relationShipView: UIView!
    @IBOutlet weak var relationshipTextField: UITextField!
    @IBOutlet weak var phoneNumberTitleLabel: UILabel!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    override func awakeFromNib() {
        self.relationShipView.layer.borderColor = UIColor(hex: "E2E4EA").cgColor
        self.relationShipView.layer.borderWidth = 1.0
        self.relationShipView.layer.cornerRadius = 25
        self.relationshipTextField.placeHolderColor = UIColor(hex: "C5CAD5")
        
        self.phoneView.layer.borderColor = UIColor(hex: "E2E4EA").cgColor
        self.phoneView.layer.borderWidth = 1.0
        self.phoneView.layer.cornerRadius = 25
        self.phoneNumberTextField.placeHolderColor = UIColor(hex: "C5CAD5")
    }
}
