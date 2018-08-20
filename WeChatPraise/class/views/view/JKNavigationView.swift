//
//  JKNavigationView.swift
//  WeChatPraise
//
//  Created by 王小腊 on 2018/8/3.
//  Copyright © 2018年 jack-wang. All rights reserved.
//

import UIKit

class JKNavigationView: UIView {
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    
    public static func loadNibClassView() ->JKNavigationView
    {
        let view: JKNavigationView = Bundle.main.loadNibNamed("JKNavigationView", owner: nil, options: nil)?.first as! JKNavigationView
        view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64)
        view.setNavGationState(isDefault: true)
        
        if UIScreen.main.bounds.height == 812 {
            
            view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 84)
        }
        return view;
        
    }
    
    /// 设置导航状态
    ///
    /// - Parameter isDefault: 默认true
    func setNavGationState(isDefault: Bool) -> Void {
        
        let color: UIColor = isDefault == true ? UIColor.clear : friendNavigationColor
        let textColor: UIColor = isDefault == true ? UIColor.white : UIColor.black
        let imageLeftName = isDefault == true ? "back_w" : "back_b"
        let imageRightName = isDefault == true ? "photo_w" : "photo_b"
        
        self.nameLabel.isHidden = isDefault
        self.backgroundColor = color
        self.leftButton.setTitleColor(textColor, for: .normal)
        self.leftButton.setImage(UIImage.init(named: imageLeftName), for: .normal)
        self.rightButton.setImage(UIImage.init(named: imageRightName), for: .normal)
        // 设置状态栏
        UIApplication.shared.statusBarStyle = isDefault ? .lightContent:.default
    }
}
