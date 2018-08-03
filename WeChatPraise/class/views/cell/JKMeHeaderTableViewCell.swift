//
//  JKMeHeaderTableViewCell.swift
//  WeChatPraise
//
//  Created by 王小腊 on 2018/8/2.
//  Copyright © 2018年 jack-wang. All rights reserved.
//

import UIKit

class JKMeHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var caderLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        self.headerImageView.layer.masksToBounds = true
        self.headerImageView.layer.cornerRadius = 4
        
        self.setUIValue()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: USER_SET_NOTICE), object: nil, queue: OperationQueue.main) { (notif) in
            
            self.setUIValue()
        }
    }
    
    func setUIValue() -> Void {
        
        let user: JKUserInfo = JKUserInfo.account()
        self.headerImageView.image = user.chatImage
        self.caderLabel.text = "微信号：\(user.chatCarde!)"
        self.nameLabel.text = user.chatName
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
