//
//  LendEasy_walletItemView.swift
//  LendEasyProject
//
//  Created by Apple on 2023/11/1.
//

import UIKit

class LendEasy_walletItemView: UIView {
    @IBOutlet weak var walletIcon: UIImageView!
    @IBOutlet weak var walletName: UILabel!
    override func awakeFromNib() {
        self.layer.cornerRadius = 8
    }
}
