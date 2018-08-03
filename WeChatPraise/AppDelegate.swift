//
//  AppDelegate.swift
//  WeChatPraise
//
//  Created by 王小腊 on 2018/7/30.
//  Copyright © 2018年 jack-wang. All rights reserved.
//

import UIKit
import Toast

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        let  userInof = JKUserInfo.account()
        // 如果没有保存个人信息就去保存
        if userInof.chatName == nil{
            
            let userVC = JKUserSetViewController.init(nibName: "JKUserSetViewController", bundle: nil)
            
            let rootVC = JKNavigationViewController.init(rootViewController: userVC)
            self.window?.rootViewController = rootVC
            
        }else{
            // 如果有就直接加载主界面
            self.setHomeRootViewController()
        }
        
        self.allToolsSet()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    // 所有工具设置
    func allToolsSet() {
        // 提示框设置
        CSToastManager.setDefaultPosition(CSToastPositionCenter)
        CSToastManager.setDefaultDuration(2)
        
        
    }
    
    /// 设置主界面
    public func setHomeRootViewController() -> Void {
        
        _ = UIApplication.shared.statusBarStyle = .lightContent
        let bar = UINavigationBar.appearance()
        bar.barTintColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.9)
        bar.tintColor = UIColor.white
        bar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        let kClassKey: String = "TableViewController"
        let kTitleKey: String = "title"
        let kImgKey: String = "imageName"
        let kSelImgKey: String = "kSelImgKey"
        
        let childItemsArray: [NSDictionary] = [
            [kClassKey:"JKHomeViewController",
             kTitleKey:"微信",
             kImgKey:"tabbar_mainframe",
             kSelImgKey:"tabbar_mainframeHL"],
            
            [kClassKey:"JKBooKViewController",
             kTitleKey:"通讯录",
             kImgKey:"tabbar_contacts",
             kSelImgKey:"tabbar_contactsHL"],
            
            [kClassKey:"JKFoundViewController",
             kTitleKey:"发现",
             kImgKey:"tabbar_discover",
             kSelImgKey:"tabbar_discoverHL"],
            
            [kClassKey:"JKMeViewController",
             kTitleKey:"我",
             kImgKey:"tabbar_me",
             kSelImgKey:"tabbar_meHL"],]
        
        let appFrameTabBarController: UITabBarController = UITabBarController.init()
        
        //这是获取项目的名称，
        let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String
        
        for  dic in childItemsArray {
            
            let className = clsName! + "." + (dic[kClassKey]! as! String)
            let viewC = NSClassFromString(className)!as! UIViewController.Type //这里需要指定类的类型XX.Type
            let vc = viewC.init()
            vc.navigationItem.title = dic[kTitleKey] as? String
            let  nav = JKNavigationViewController.init(rootViewController: vc)
            
            let item = nav.tabBarItem
            item?.title = dic[kTitleKey] as? String
            item?.image = UIImage.init(named: (dic[kImgKey] as? String)!)
            item?.selectedImage = UIImage.init(named: (dic[kSelImgKey] as? String)!)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            item?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : tabTextColor], for: .selected)
            appFrameTabBarController.addChildViewController(nav)
        }
        
        self.window?.rootViewController = appFrameTabBarController
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

