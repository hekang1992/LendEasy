//
//  LendEasy_progressView.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/12.
//

import UIKit

class LendEasy_progressView: UIView {

    @IBOutlet weak var firstProgressView: UIView!
    @IBOutlet weak var firstProgressIcon: UIImageView!
    
    @IBOutlet weak var secondProgressView: UIView!
    @IBOutlet weak var secondProgressIcon: UIImageView!
    @IBOutlet weak var secondProgressCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var thirdProgressView: UIView!
    @IBOutlet weak var thirdProgressIcon: UIImageView!
    @IBOutlet weak var thirdProgressCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var fourthProgressView: UIView!
    @IBOutlet weak var fourthProgressIcon: UIImageView!
    
    @IBOutlet weak var currentProgressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.firstProgressView.layer.cornerRadius = 12
        self.secondProgressView.layer.cornerRadius = 12
        self.thirdProgressView.layer.cornerRadius = 12
        self.fourthProgressView.layer.cornerRadius = 12
        
        self.secondProgressView.mas_remakeConstraints { make in
            make?.centerX.equalTo()(self.currentProgressView.mas_centerX)?.offset()(-(SCREEN_WIDTH - 96)/6)
            make?.centerY.equalTo()(self.currentProgressView)
            make?.width.equalTo()(24)
            make?.height.equalTo()(24)
        }
        
        self.thirdProgressView.mas_remakeConstraints { make in
            make?.centerX.equalTo()(self.currentProgressView.mas_centerX)?.offset()((SCREEN_WIDTH - 96)/6)
            make?.centerY.equalTo()(self.currentProgressView)
            make?.width.equalTo()(24)
            make?.height.equalTo()(24)
        }

    }
}
