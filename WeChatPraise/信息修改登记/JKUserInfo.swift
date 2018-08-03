//
//  JKUserInfo.swift
//  WeChatPraise
//
//  Created by 王小腊 on 2018/7/31.
//  Copyright © 2018年 jack-wang. All rights reserved.
//

import UIKit
import Toast

let path = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!)/user.data"


class JKUserInfo: NSObject,NSCoding {
    
    public var chatName : String? = nil
    public var chatCarde: String? = nil
    public var chatSex  : String? = nil
    public var chatImage : UIImage? = nil
    public var chatFriendsImgae : UIImage? = nil
    
    public let chatImagePath = "\(NSHomeDirectory())/Documents/chatImage.png"
    public let chatFriendsPath = "\(NSHomeDirectory())/Documents/chatFriends.png"
    
    
    static public func saveAccount(userInfo: JKUserInfo) -> Bool{
        
        NSKeyedArchiver.archiveRootObject(userInfo, toFile: path)
        
        let saveBool = NSKeyedArchiver.archiveRootObject(userInfo, toFile: path)
        
        do {
            try  UIImagePNGRepresentation(userInfo.chatImage!)?.write(to: URL.init(fileURLWithPath: userInfo.chatImagePath))
            try  UIImagePNGRepresentation(userInfo.chatFriendsImgae!)?.write(to: URL.init(fileURLWithPath: userInfo.chatFriendsPath))
        } catch {}
        
        
        if saveBool == true {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: USER_SET_NOTICE), object: nil)
        }
        return saveBool
        
    }
    
    static public func account() ->JKUserInfo{
        
        print(path)
        let object: JKUserInfo? = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? JKUserInfo
        
        if object == nil {
            
            return JKUserInfo.init()
        }
        
        object?.chatImage =  UIImage.init(contentsOfFile: (object?.chatImagePath)!)
        object?.chatFriendsImgae =  UIImage.init(contentsOfFile: (object?.chatFriendsPath)!)
        
        return  object!
    }
    
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.chatName, forKey: "chatName")
        aCoder.encode(self.chatCarde, forKey: "chatCarde")
        aCoder.encode(self.chatSex, forKey: "chatSex")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.chatName = aDecoder.decodeObject(forKey: "chatName") as? String
        self.chatCarde = aDecoder.decodeObject(forKey: "chatCarde") as? String
        self.chatSex = aDecoder.decodeObject(forKey: "chatSex") as? String
    }
    
    override init() {
        super.init()
    }
    
    
}
