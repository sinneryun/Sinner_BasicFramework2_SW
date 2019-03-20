//
//  BaseTableViewController.swift
//  xiaohailang
//
//  Created by 刘达浮云 on 2019/2/18.
//  Copyright © 2019 刘达浮云. All rights reserved.
//

import UIKit
import MJRefresh

class BaseTableViewController: BaseViewController {

    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        //解决iOS11滚动条高度跳动、上下拉刷新问题
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        
        //刷新加载
        tableView.mj_header = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(refreshFetchData))
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadFetchData))
    }
    
    lazy var tableView : UITableView = {
        
        let tab = UITableView(frame: view.bounds, style: .plain)
        tab.backgroundColor = .white
        tab.separatorStyle = .none
        tab.dataSource = self
        tab.delegate = self
        
        return tab
    }()
    
    //tableView基础设置
    func tableViewConfig() {
        
    }
    
    // MARK:- 刷新加载相关方法
    func fetchData() {
        
    }
    
    @objc func refreshFetchData() {
        
    }
    
    @objc func loadFetchData() {
        
    }
    
    func showPullToRefresh() {
        tableView.mj_header.isHidden = false
    }
    
    func hidePullToRefresh() {
        tableView.mj_header.isHidden = true
    }
    
    func showLoadMore() {
        tableView.mj_footer.isHidden = false
    }
    
    func hideLoadMore() {
        tableView.mj_footer.isHidden = true
    }
    
    func endRefresh() {
        tableView.mj_header.endRefreshing()
    }
    
    func endRefreshAndLoadMore() {
        if tableView.mj_header.isRefreshing {
            tableView.mj_header.endRefreshing()
        }else if tableView.mj_footer.isRefreshing {
            tableView.mj_footer.endRefreshing()
        }
    }
    
    func endLoadWithMore() {
        tableView.mj_footer.isHidden = false
        tableView.mj_footer.endRefreshing()
    }
    
    func endLoadWithNoMore() {
        tableView.mj_footer.isHidden = false
        tableView.mj_footer.endRefreshingWithNoMoreData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:- UITableViewDelegate & UITableViewDataSource
extension BaseViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
