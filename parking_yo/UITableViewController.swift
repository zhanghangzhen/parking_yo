//
//  UITableViewController.swift
//  parking_yo
//
//  Created by zhanghangzhen on 16/4/12.
//  Copyright © 2016年 zhanghangzhen. All rights reserved.
//

import UIKit

class UITableViewController: UIViewController,UITableViewDelegate {

    var tableView = UITableView()
    var page: Int?
    var dataSource: ContentTableDatasource? {
        didSet {
            tableView.dataSource = dataSource
        }
    }
    var pageID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setUpTableView()
    }
    
    func setUpTableView() {
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(view)
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        // 下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: dataSource, refreshingAction: Selector("updateInfoList"))
        tableView.mj_header.beginRefreshing()
        // 上拉刷新
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: dataSource, refreshingAction: "loadMoreInfo")
        
    }


}
