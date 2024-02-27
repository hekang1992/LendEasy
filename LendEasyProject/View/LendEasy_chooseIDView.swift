//
//  LendEasy_chooseIDView.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/11.
//

import UIKit

class LendEasy_chooseIDView: UIView {
    @IBOutlet weak var IdNameLabel: UILabel!
    @IBOutlet weak var rightIcon: UIImageView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var clickBtn: UIButton!
    var chooseIDBlock:((NSInteger)->())?
    override func awakeFromNib() {
        
    }
    
    
    @IBAction func chooseIDAction(_ sender: UIButton) {
        chooseIDBlock?(sender.tag)
    }
}
