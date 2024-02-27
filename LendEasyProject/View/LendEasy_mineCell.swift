//
//  LendEasy_mineCell.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/17.
//

import UIKit

class LendEasy_mineCell: UITableViewCell {
    @IBOutlet weak var whiteContentView: UIView!
    @IBOutlet weak var mineIcon: UIImageView!
    @IBOutlet weak var mineTitleLabel: UILabel!
    @IBOutlet weak var mineArrow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.whiteContentView.layer.cornerRadius = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
