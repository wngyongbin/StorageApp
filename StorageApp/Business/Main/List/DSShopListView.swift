//
//  DSShopListView.swift
//  StorageApp
//
//  Created by ascii on 16/7/28.
//  Copyright © 2016年 DSB. All rights reserved.
//

import UIKit

class DSShopListView: UIView, UITableViewDelegate, UITableViewDataSource {
    private var dataSource: [DSShopModel]? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.listHeaderView)
        self.listHeaderView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self).offset(160)
            make.height.equalTo(50)
        }
        
        self.addSubview(self.tableView)
        self.tableView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(self.listHeaderView.snp_bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDataSource(dataSource: [DSShopModel]) -> Void {
        self.dataSource = dataSource
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource, UITableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = self.dataSource {
            return array.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 94
//    }
//    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return self.slideHeaderView
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = (tableView.dequeueReusableCellWithIdentifier(String(DSShopListCell)) as? DSShopListCell) {
            cell.titleLabel.text = self.dataSource?[indexPath.row].name
            cell.selectionStyle = .None
            
            if let selected = self.dataSource?[indexPath.row].isSelected {
                if selected {
                    tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.None)
                }
            }
            return cell
        }
        return UITableViewCell.init()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let dataSource = self.dataSource {
            for idx in 0 ..< dataSource.count {
                let model = dataSource[idx]
                if idx == indexPath.row {
                    model.isSelected = true
                } else {
                    model.isSelected = false
                }
            }
        }
        self.listHeaderView.actionButton.sendActionsForControlEvents(.TouchUpInside)
    }
    
    // Mark: - Property
    
    lazy var listHeaderView: DSShopListHeaderView = {
        var view = DSShopListHeaderView.init(frame: CGRectZero)
        view.backgroundColor = UIColor.init(rgb: 0x1fbad6)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRectZero, style: UITableViewStyle.Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.allowsMultipleSelection = false
        tableView.backgroundColor = UIColor.init(rgb: 0xffffff)
        tableView.registerClass(DSShopListCell.self, forCellReuseIdentifier: String(DSShopListCell))
        return tableView
    }()
}
