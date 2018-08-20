//
//  JKHomeViewController.swift
//  WeChatPraise
//
//  Created by 王小腊 on 2018/8/1.
//  Copyright © 2018年 jack-wang. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class JKHomeViewController: UIViewController {
    
    var homeRootList:[JKHomeMode]?
    let tableView: UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), style: UITableViewStyle.plain)
    
    let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setTableViewType()
        self.dataLoad()
        self.setUpViews()
        

    }
    // 设置视图
    func setUpViews() -> Void {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.add, target: nil, action: nil)
        self.navigationController?.tabBarItem.badgeValue = "1"
        self.navigationItem.title = "微信(1)"
        
        let searchVC = UIViewController.init()
        searchVC.view.backgroundColor = tableBackColor
        
        let searchController = UISearchController.init(searchResultsController: searchVC)
        searchController.view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        
        let searchView = searchController.searchBar
        searchView.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 50)
        searchView.setImage(UIImage.init(named: "VoiceSearchStartBtn"), for: .bookmark, state: .normal)
        searchView.searchBarStyle = .default
        searchView.isTranslucent = true
        searchView.delegate = self
        searchView.showsBookmarkButton = true
        searchView.backgroundImage = UIImage.init()
        searchView.placeholder = "搜索"
        searchView.barTintColor = cellSelectedBackColor
        self.tableView.tableHeaderView = searchView
        
    }
    // table样式设置
    func setTableViewType() -> Void {
        
        self.tableView.backgroundColor = tableBackColor
        self.tableView.estimatedRowHeight = 60
        self.tableView.separatorStyle = .singleLine
        self.tableView.register(UINib.init(nibName: "JKHomeTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { (make) in
            
            make.edges.equalToSuperview()
        }
    }
    
    // 数据初始化
    func dataLoad() -> Void {
        
        // 获得 Plist 文件的全路径
        let path = Bundle.main.path(forResource: "homeData", ofType:"plist")
        // 加载 plist 文件
        let data = NSArray(contentsOfFile: path!)
        
        self.homeRootList = Mapper<JKHomeMode>().mapArray(JSONArray: data as! [[String : Any]])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//MARK: --tableView代理
extension  JKHomeViewController:UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeRootList!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: JKHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! JKHomeTableViewCell
        let mode: JKHomeMode = self.homeRootList![indexPath.row]
        cell.updataCellText(objec: mode)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
    }
}
//MARK: -- 数据模型
import ObjectMapper
class JKHomeMode: Mappable {
    
    
    public var cellNmae: String?
    public var cellIcon: String?
    public var cellMsg: String?
    public var cellTime: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        cellNmae <- map["name"]
        cellIcon <- map["icon"]
        cellMsg <- map["msg"]
        cellTime <- map["time"]
    }
    
}
