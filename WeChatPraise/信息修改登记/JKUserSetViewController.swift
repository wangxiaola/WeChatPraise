//
//  JKUserSetViewController.swift
//  WeChatPraise
//
//  Created by 王小腊 on 2018/7/30.
//  Copyright © 2018年 jack-wang. All rights reserved.
//

import UIKit
import Toast

class JKUserSetViewController: UIViewController,JKPhotosSelectedToolDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var chatCadTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    
    @IBOutlet weak var chatPhotosButton: UIButton!
    @IBOutlet weak var friendsPhotosButton: UIButton!
    
    private  var photosSelectedTool: JKPhotosSelectedTool?
    
    private  var chatImgae: UIImage?
    private  var friendsImgae: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "基本信息填写"
        self.setViewUI()
        
    }
    
    func setViewUI() -> Void {
                
        let user: JKUserInfo = JKUserInfo.account()
        
        if user.chatFriendsImgae != nil {
            
            self.nameTextField.text = user.chatName
            self.chatCadTextField.text = user.chatCarde
            self.sexTextField.text = user.chatSex
            
            self.chatImgae = user.chatImage
            self.friendsImgae = user.chatFriendsImgae
            
            self.chatPhotosButton.setImage(self.chatImgae!, for: UIControlState.normal)
            self.friendsPhotosButton.setImage(self.friendsImgae!, for: UIControlState.normal)
        }

    }
    // MARK: - 点击事件
    @IBAction func showSexSelection(_ sender: UIButton) {
        
        let alertVC = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let box = UIAlertAction.init(title: "男", style: UIAlertActionStyle.default) { (ac) in
            
            self.sexTextField.text = "男"
        }
        let gar = UIAlertAction.init(title: "女", style: UIAlertActionStyle.default) { (ac) in
            
            self.sexTextField.text = "女"
        }
        
        let cancel = UIAlertAction.init(title: "取 消", style: UIAlertActionStyle.cancel) { (ac) in
        }
        alertVC.addAction(box)
        alertVC.addAction(gar)
        alertVC.addAction(cancel)
        self.present(alertVC, animated: true, completion: nil)
        
    }
    @IBAction func showChatPhotos(_ sender: Any) {
        
        
        self.photoSelectedResults(isFriends: false)
        
    }
    @IBAction func showFriendsPhontos(_ sender: Any) {
        
        self.photoSelectedResults(isFriends: true)
    }
    // 保存
    @IBAction func saveUserInfo(_ sender: Any) {
        
        if self.nameTextField.text?.count == 0 {
            self.view.makeToast("请输入微信昵称")
            return;
        }
        if self.chatCadTextField.text?.count == 0 {
            self.view.makeToast("请输入微信号")
            return;
        }
        if self.sexTextField.text?.count == 0 {
            self.view.makeToast("请选择您的性别")
            return;
        }
        if self.chatImgae == nil {
            self.view.makeToast("请选择微信头像")
            return;
        }
        if self.friendsImgae == nil {
            self.view.makeToast("请选择朋友圈背景图片")
            return;
        }
        
        
        let userInfo = JKUserInfo.init()
        userInfo.chatName = self.nameTextField.text
        userInfo.chatSex = self.sexTextField.text
        userInfo.chatCarde = self.chatCadTextField.text
        userInfo.chatImage = self.chatImgae
        userInfo.chatFriendsImgae = self.friendsImgae
        // 保存
        if  JKUserInfo.saveAccount(userInfo: userInfo){
            
            self.view.makeToast("保存成功")
            let ws = UIApplication.shared.delegate as! AppDelegate
            ws.setHomeRootViewController()
            
        }else
        {
            self.view.makeToast("保存失败")
        }
    }
    
    func photoSelectedResults(isFriends: Bool) -> Void {
        
        // 开始选择照片
        if self.photosSelectedTool == nil {
            
            self.photosSelectedTool = JKPhotosSelectedTool.init(perentVC: self)
            
        }
        self.photosSelectedTool?.selectedPhotoNumber(num: 1)
        self.photosSelectedTool?.photosSelectedToolDelegate = self
        // 图片回调
        self.photosSelectedTool?.photosSelectedComplete = {(images: [UIImage]) ->Void in
            
            let image = images.last
            
            if isFriends {
                
                self.friendsPhotosButton.setImage(image, for: .normal)
                self.friendsImgae = image
            }else{
                
                self.chatPhotosButton.setImage(image, for: .normal)
                self.chatImgae = image
            }
        }
    }
    
    ///MARK: -图片选择代理
    func photosSelectedComplete(photos: [UIImage]) {
    }
    
}

// MARK: - 图片选择工具
/// 代理方法
protocol JKPhotosSelectedToolDelegate:NSObjectProtocol {
    
    func photosSelectedComplete(photos: [UIImage]) -> Void
    
}
/// 闭包方法
typealias photosSelectedComplete = (_ imageArray: [UIImage]) ->Void

// 相册选择工具
import Photos
import AssetsLibrary

class JKPhotosSelectedTool: NSObject {
    
    public weak var photosSelectedToolDelegate: JKPhotosSelectedToolDelegate?
    
    public var photosSelectedComplete: photosSelectedComplete?
    
    private var photosNumber: Int = 0
    
    private var photosPicker: UIImagePickerController?
    
    private weak var controller: UIViewController?
    
    
    public init(perentVC: UIViewController) {
        
        super.init()
        self.controller = perentVC
        
    }
    /// 选择几张图片
    ///
    /// - Parameter num: 几张
    public  func selectedPhotoNumber(num: Int) -> Void {
        
        self.photosNumber = num
        self.photosShow()
    }
    
    private func photosShow(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
            
            if self.photosPicker == nil
            {
                
                self.photosPicker = UIImagePickerController()
                // 图库类型
                self.photosPicker?.sourceType = UIImagePickerControllerSourceType.photoLibrary
                // 代理对象（注意添加协议 UIImagePickerControllerDelegate、UINavigationControllerDelegate，及实现代理方法）
                self.photosPicker?.delegate = self
                // 设置图片可编辑
                self.photosPicker?.allowsEditing = false
                // 改navigationBar背景色
                self.photosPicker?.navigationBar.barTintColor = navigationColor
                // 改navigationBar标题色
                self.photosPicker?.navigationBar.isTranslucent = false
                self.photosPicker?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
                // 改navigationBar的button字体色
                self.photosPicker?.navigationBar.tintColor = UIColor.white
            }
            // 弹出图库视图控制器
            
            self.controller?.present(self.photosPicker!, animated: true, completion: nil)
            
        }
        else
        {
            print("打开图片失败")
        }
    }
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension JKPhotosSelectedTool: UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            // 数据传递
            self.photosSelectedToolDelegate?.photosSelectedComplete(photos: [image])
            self.photosSelectedComplete?([image])
        }else{
            print("pick image wrong")
        }
        // 收回图库选择界面
        self.photosPicker?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 退出图片选择控制器
        self.photosPicker?.dismiss(animated: true, completion: nil)
    }
}


