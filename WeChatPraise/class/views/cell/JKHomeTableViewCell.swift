//
//  JKHomeTableViewCell.swift
//  WeChatPraise
//
//  Created by 王小腊 on 2018/8/1.
//  Copyright © 2018年 jack-wang. All rights reserved.
//

import UIKit

class JKHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.timeLabel.textColor = grayTextColor
        self.msgLabel.textColor = grayTextColor
    }

    public func updataCellText(objec: JKHomeMode) -> Void {
        
        self.photoImage!.image = UIImage.init(named: objec.cellIcon!)
        self.nameLabel!.text = objec.cellNmae!
        self.timeLabel!.text = objec.cellTime!
        self.msgLabel!.text = objec.cellMsg!
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
