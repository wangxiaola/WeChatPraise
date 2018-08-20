//
//  JKMeViewController.swift
//  WeChatPraise
//
//  Created by 王小腊 on 2018/8/2.
//  Copyright © 2018年 jack-wang. All rights reserved.
//

import UIKit

class JKMeViewController: UITableViewController {
    
     let listData = NSMutableArray.init()
     let cellIdentifierHeader = "cellHeader"
     let cellIdentifier = "cellIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()

        listData.add([["image":"","name":""]])
        listData.add([["image":"MoreMyBankCard","name":"钱包"]])
        listData.add([["image":"MoreMyFavorites","name":"收藏"],
                      ["image":"MoreMyAlbum","name":"相册"],
                      ["image":"MyCardPackageIcon","name":"卡包"],
                      ["image":"MoreExpressionShops","name":"表情"]])
        listData.add([["image":"MoreSetting","name":"设置"]])

        self.tableView.sectionHeaderHeight = 10
        self.tableView.sectionFooterHeight = 10
        self.tableView.estimatedRowHeight = 40
        self.tableView.tableFooterView = UIView.init()
        self.tableView.tableHeaderView = UIView.init()
        self.view.backgroundColor = tableBackColor
        self.tableView.register(UINib.init(nibName: "JKBookTableViewCell", bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
        self.tableView.register(UINib.init(nibName: "JKMeHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: self.cellIdentifierHeader)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- tableview代理
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return listData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let data:[Any] = listData[section] as! [Any]
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 80 : 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell: JKMeHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier:self.cellIdentifierHeader) as! JKMeHeaderTableViewCell
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator//添加箭头
            
            return cell
        }
        let cell: JKBookTableViewCell = tableView.dequeueReusableCell(withIdentifier:self.cellIdentifier) as! JKBookTableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator//添加箭头
        
        let list:[Any] = self.listData[indexPath.section] as! [Any]
        let data: [String: String] = list[indexPath.row] as! [String : String]
        cell.nameLabel.text = data["name"]
        cell.headerImage.image = UIImage.init(named: data["image"]!)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let userVC = JKUserSetViewController.init(nibName: "JKUserSetViewController", bundle: nil)
        userVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(userVC, animated: true)
    }
}
