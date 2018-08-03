//
//  JKBookTableViewCell.swift
//  WeChatPraise
//
//  Created by 王小腊 on 2018/8/2.
//  Copyright © 2018年 jack-wang. All rights reserved.
//

import UIKit

class JKBookTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
