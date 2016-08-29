//
//  FKBuyingBtnCell.swift
//  StorageApp
//
//  Created by jack on 16/8/26.
//  Copyright © 2016年 DSB. All rights reserved.
//

import UIKit

class DSSDeliverActionCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .None
        self.backgroundColor = UIColor.whiteColor()
        
        self.addAllSubviews();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func fk_configWith(viewModel: AnyObject, indexPath: NSIndexPath) {
        if let dViewModel = viewModel as? DSSDeliverViewModel {
            if let missionModel = dViewModel.missionModelAtIndexPath(indexPath) {
                if let itemID = missionModel.itemID {
                    self.titleLabel.text = "运单号：" + itemID
                } else {
                    self.titleLabel.text = nil
                }
            }
        }
    }

    func alignStatusCellRight() -> Void {
        if let text = self.titleLabel.text {
            let attr = [NSFontAttributeName: self.titleLabel.font]
            let size = (text as NSString).sizeWithAttributes(attr)
            self.titleLabel.textAlignment = .Center
            self.titleLabel.backgroundColor = UIColor.init(rgb: 0xf4f4f4)
            self.titleLabel.textColor = UIColor.init(rgb: 0x999999)
            self.titleLabel.layer.cornerRadius = 2
            self.titleLabel.clipsToBounds = true
            
            self.titleLabel.snp_remakeConstraints{ (make) in
                make.right.equalTo(self.contentView).offset(-16)
                make.centerY.equalTo(self.contentView)
                make.width.equalTo((size.width + 14))
            }
        } else {
            self.titleLabel.hidden = true
        }
    }
    
    // MARK: - Layout
    
    func addAllSubviews() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(16)
            make.centerY.equalTo(self.contentView)
        }
        
        self.contentView.addSubview(self.deliverButton)
        self.deliverButton.snp_makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-16)
            make.centerY.equalTo(self.contentView)
            make.size.equalTo(CGSizeMake(100, 25))
        }
    }
    
    // MARK: - Property
    
    lazy var titleLabel: UILabel = {
        var label = UILabel.init()
        label.textColor = UIColor.init(rgb: 0x666666)
        label.font = UIFont.systemFontOfSize(13)
        label.numberOfLines = 2
        return label
    }()

    lazy var deliverButton: UIButton = {
        let button = UIButton.init(type: UIButtonType.Custom)
        button.setTitle("确认发货", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        button.backgroundColor = UIColor.init(rgb: 0x1fbad6)
        button.layer.cornerRadius = 3.0
        return button
    }()
}