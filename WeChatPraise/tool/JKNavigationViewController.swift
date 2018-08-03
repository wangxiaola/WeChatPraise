//
//  JKNavigationViewController.swift
//  WeChatPraise
//
//  Created by 王小腊 on 2018/7/30.
//  Copyright © 2018年 jack-wang. All rights reserved.
//

import UIKit

class JKNavigationViewController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = navigationColor
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        
    }

    override func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {        super.setNavigationBarHidden(hidden, animated: animated)
        // 接管导航控制器的边缘侧滑返回交互手势代理
        interactivePopGestureRecognizer?.delegate = self
    }
    

    func UIGestureRecognizerDelegate() {
        
        // 让边缘侧滑手势在合适的情况下生效
        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            if (self.viewControllers.count > 1)
            {
                return true;
            }
            return false;
        }
        // 允许同时响应多个手势
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
        // 避免响应边缘侧滑返回手势时，当前控制器中的ScrollView跟着滑动
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self
            )
        }
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
