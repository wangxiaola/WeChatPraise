//
//  JKFriendsTableViewCell.swift
//  WeChatPraise
//
//  Created by 王小腊 on 2018/8/3.
//  Copyright © 2018年 jack-wang. All rights reserved.
//

import UIKit

class JKFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerNameLabel: UILabel!
    @IBOutlet weak var headerMsgLabel: UILabel!
    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var clickMsdButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var bottomViewHeigheValue: NSLayoutConstraint!
    @IBOutlet weak var contenViewHeightValue: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.bottomViewHeigheValue.constant = 100.0
        self.contenViewHeightValue.constant = 0.0
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
