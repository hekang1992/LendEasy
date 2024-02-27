//
//  LendEasy_HomeProductCell.swift
//  LendEasyProject
//
//  Created by Apple on 2023/11/6.
//

import UIKit

class LendEasy_HomeProductCell: UITableViewCell {
    @IBOutlet weak var productIcon: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var firstResultLabel: UILabel!
    @IBOutlet weak var secondResultLabel: UILabel!
    @IBOutlet weak var operationBtn: UIButton!
    @IBOutlet weak var contentBgView: UIView!
    @IBOutlet weak var resultBgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentBgView.layer.cornerRadius = 8.0
        self.contentBgView.clipsToBounds = true
        
        self.resultBgView.layer.cornerRadius = 6.0
        self.resultBgView.clipsToBounds = true
        
        self.operationBtn.layer.cornerRadius = 22
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
