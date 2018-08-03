//
//  JKFriendsTableViewController.swift
//  WeChatPraise
//
//  Created by 王小腊 on 2018/8/3.
//  Copyright © 2018年 jack-wang. All rights reserved.
//

import UIKit

/// 朋友圈
class JKFriendsTableViewController: UIViewController {
    
    let cellIdentifier = "cellIdentifier"
    let tableView: UITableView  = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: UITableViewStyle.plain)
    
    let navView: JKNavigationView = JKNavigationView.loadNibClassView()
    let headerView: JKFriendHeaderView = JKFriendHeaderView.loadNibClassView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false , animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewsUI()
        
        
        
    }
    //MAEK:-设置头部视图
    func setViewsUI() -> Void {
        
        self.extendedLayoutIncludesOpaqueBars = true;
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        self.view.addSubview(self.tableView)
        self.view.backgroundColor = tableBackColor
        self.tableView.backgroundColor = tableBackColor
        self.tableView.tableHeaderView = self.headerView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(UINib.init(nibName: "JKFriendsTableViewCell", bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
        
        self.view.addSubview(self.navView)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
   //MARK:- tableview代理
extension JKFriendsTableViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 12
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: JKFriendsTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as! JKFriendsTableViewCell
        return cell
    }
    
}
