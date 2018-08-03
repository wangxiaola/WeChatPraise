//
//  JKBooKViewController.swift
//  WeChatPraise
//
//  Created by 王小腊 on 2018/8/1.
//  Copyright © 2018年 jack-wang. All rights reserved.
//

import UIKit

class JKBooKViewController: UITableViewController {
    
    var searchController: UISearchController?
    var sectionArray: NSMutableArray = NSMutableArray.init()
    var sectionTitlesArray: NSMutableArray = NSMutableArray.init()
    var dataArray: NSMutableArray = NSMutableArray.init()
    
    let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = tableBackColor

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "add_friend"), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        self.searchController = UISearchController.init(searchResultsController: UITableViewController.init())
        self.searchController?.view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        
        let searchView = self.searchController!.searchBar
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
        
        self.tableView.separatorStyle = .singleLine
        self.tableView.sectionHeaderHeight = 20
        self.tableView.rowHeight = 50
        self.tableView.separatorColor = cellSelectedBackColor
        self.tableView.sectionIndexColor = UIColor.black
        self.tableView.sectionIndexBackgroundColor = UIColor.clear
        self.tableView.register(UINib.init(nibName: "JKBookTableViewCell", bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
        self.genDataWithCount(number: 40)
        
        self.tableView.reloadData()
    }
    // 加载数据数量
    func genDataWithCount(number: Int) -> Void {
        
        let xings = ["赵","钱","孙","李","周","吴","郑","王","冯","陈","楚","卫","蒋","沈","韩","杨"]
        
        let ming1 = ["大","美","帅","应","超","海","江","湖","春","夏","秋","冬","上","左","有","纯"]
        
        let ming2 = ["强","好","领","亮","超","华","奎","海","工","青","红","潮","兵","垂","刚","山"]
        
        // 循环添加数据
        for _ in 0..<number {
            
            var name: String = xings[Int(arc4random_uniform(UInt32(xings.count)))]
            let ming: String = ming1[Int(arc4random_uniform(UInt32(ming1.count)))]
            
            name = "\(name)\(ming)"
            
            if arc4random_uniform(10) > 3 {
                
                let suffix = ming2[Int(arc4random_uniform(UInt32(ming2.count)))]
                name = "\(name)\(suffix)"
                
            }
            
            let mode: JKBookListMode = JKBookListMode.init()
            mode.name = name
            mode.imageName = "\(arc4random_uniform(22))"
            self.dataArray.add(mode)
        }
        
        self.setUpTableSection()
        
    }
    
    // MARK: - 设置搜索数据
    func setUpTableSection() -> Void {
        
        let collation: UILocalizedIndexedCollation = UILocalizedIndexedCollation.current()
        let newSectionArray = NSMutableArray.init()
        
        let numberOfSections = collation.sectionTitles.count
        
        for _ in 0..<numberOfSections {
            
            newSectionArray.add(NSMutableArray.init())
        }
        
        for model in self.dataArray {
            let object: JKBookListMode = model as! JKBookListMode
            
            let sectionIndex = collation.section(for: object, collationStringSelector: #selector(getter: object.name))
            
            (newSectionArray[sectionIndex] as! NSMutableArray).add(object)
        }
        
        for index in 0..<numberOfSections {
            
            let personsForSection:[Any] = newSectionArray[index] as! [Any]
            let sortedPersonsForSection = collation.sortedArray(from: personsForSection , collationStringSelector: #selector(getter: MTLFunction.name))
            newSectionArray[index] = sortedPersonsForSection
            
        }
        
        let temp = NSMutableArray.init()
        
        newSectionArray.enumerateObjects { (arr, idx, stop) in
            
            let data = arr as! [Any]
            
            if data.count == 0 {
                
                temp.add(data)
            }
            else
            {
                self.sectionTitlesArray.add(collation.sectionTitles[idx])
            }
        }
        newSectionArray.removeObjects(in: temp as! [Any])
        
        let operrationModels = NSMutableArray.init()
        let dicts = [
            ["name" : "新的朋友", "imageName" : "plugins_FriendNotify"],
            ["name" : "群聊", "imageName" : "add_friend_icon_addgroup"],
            ["name" : "标签", "imageName" : "Contact_icon_ContactTag"],
            ["name" : "公众号", "imageName" : "add_friend_icon_offical"]]
        
        for dict in dicts {
            
            let list = JKBookListMode.init()
            list.name = dict["name"]
            list.imageName = dict["imageName"]
            operrationModels.add(list)
        }
        
        newSectionArray.insert(operrationModels, at: 0)
        self.sectionTitlesArray.insert("", at: 0)
        self.sectionArray = newSectionArray
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sectionTitlesArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.sectionArray[section] as! [Any]).count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: JKBookTableViewCell = tableView.dequeueReusableCell(withIdentifier:self.cellIdentifier) as! JKBookTableViewCell
        
        let list:[Any] = self.sectionArray[indexPath.section] as! [Any]
        
        let mode: JKBookListMode = list[indexPath.row] as! JKBookListMode
        
        cell.nameLabel.text = mode.name
        cell.headerImage.image = UIImage.init(named: mode.imageName!)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.sectionTitlesArray[section] as? String
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let view: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        view.textLabel?.textColor = grayTextColor
        view.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
    }
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        return self.sectionTitlesArray as? [String]
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
    }
    
}
//MARK: -- 搜索代理
extension JKBooKViewController: UISearchBarDelegate{
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
    }
    
}

class JKBookListMode: NSObject {
    
    @objc var name: String?
    var wxId: String?
    var imageName: String?
    
}


