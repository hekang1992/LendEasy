//
//  LendEasy_OrderCell.swift
//  LendEasyProject
//
//  Created by Apple on 2023/11/7.
//

import UIKit

class LendEasy_OrderCell: UITableViewCell {
    @IBOutlet weak var contentBgView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var orderStateLabel: UILabel!
    @IBOutlet weak var daterTitleLabel: UILabel!
    @IBOutlet weak var daterLabel: UILabel!
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var firstResultLabel: UILabel!
    @IBOutlet weak var secondResultLabel: UILabel!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var tipLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentBgView.layer.cornerRadius = 8.0
        
        self.changeBtn.layer.cornerRadius = 17
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
