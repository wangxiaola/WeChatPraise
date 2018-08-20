//
//  JKFriendHeaderView.swift
//  WeChatPraise
//
//  Created by 王小腊 on 2018/8/3.
//  Copyright © 2018年 jack-wang. All rights reserved.
//

import UIKit

let headerHeight = UIScreen.main.bounds.height*0.46

class JKFriendHeaderView: UIView {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    public static func loadNibClassView() ->JKFriendHeaderView
    {
        let view: JKFriendHeaderView = Bundle.main.loadNibNamed("JKFriendHeaderView", owner: nil, options: nil)?.first as! JKFriendHeaderView
        view.frame = CGRect.init(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: Int(headerHeight))
        
        let user: JKUserInfo? = JKUserInfo.account()
        
        view.photoImageView.image = user?.chatImage
        view.backImageView.image = user?.chatFriendsImgae
        
        return view;
        

        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
