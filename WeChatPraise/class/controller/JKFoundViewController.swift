//
//  JKFoundViewController.swift
//  WeChatPraise
//
//  Created by 王小腊 on 2018/8/2.
//  Copyright © 2018年 jack-wang. All rights reserved.
//

import UIKit

class JKFoundViewController: UITableViewController {
    
    let listData = NSMutableArray.init()
    let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listData.add([["image":"ff_IconShowAlbum","name":"朋友圈"]])
        listData.add([["image":"ff_IconQRCode","name":"扫一扫"],["image":"ff_IconShake","name":"摇一摇"]])
        listData.add([["image":"discover_read","name":"看一看"],["image":"discover_search","name":"搜一搜"]])
        listData.add([["image":"ff_IconLocationService","name":"附近的人"]])
        listData.add([["image":"CreditCard_ShoppingBag","name":"购物"],["image":"MoreGame","name":"游戏"]])
        listData.add([["image":"discover_app","name":"小程序"]])
        
        self.tableView.sectionFooterHeight = 10
        self.tableView.sectionHeaderHeight = 10
        self.tableView.estimatedRowHeight = 40
        self.tableView.tableFooterView = UIView.init()
        self.tableView.tableHeaderView = UIView.init()
        self.view.backgroundColor = tableBackColor
        self.tableView.register(UINib.init(nibName: "JKBookTableViewCell", bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
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
        return 40
    }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            let vc = JKFriendsTableViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
