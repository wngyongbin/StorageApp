//
//  DSSEditProItem.swift
//  StorageApp
//
//  Created by jack on 16/6/29.
//  Copyright © 2016年 DSB. All rights reserved.
//

import UIKit
//import ObjectMapper

class DSSEditItem: NSObject {

    var infoItem : DSSEditInfoItem?
    var specItem : DSSEditSpecItem?
    var picItems : [DSSEditImgItem]?
    
    func isDataComplete() -> (complete: Bool, error: String?) {
        
        var complete = true
        var errorStr: String?
        
        if self.picItems?.count == 0 {
            complete = false
            errorStr = "Add at least one photo"
        } else if self.infoItem?.price == nil || self.infoItem?.price == 0 {
            complete = false
            errorStr = "Type Price"
        } else if self.specItem?.stock == nil || Int((self.specItem?.stock)!) <= 0 {
            complete = false
            errorStr = "Type Inventory"
        } else if self.specItem?.weight == nil || Int((self.specItem?.weight)!) <= 0 {
            complete = false
            errorStr = "Type Weight"
        }else if self.specItem?.upcStr == nil || self.specItem?.upcStr?.characters.count == 0 {
            complete = false
            errorStr = "Type UPC"
        } else if self.specItem?.siteSku == nil || self.specItem?.siteSku?.characters.count == 0 {
            complete = false
            errorStr = "Type Item number"
        }
        
        if self.infoItem?.name != nil && self.infoItem?.name?.characters.count > 255 {
            complete = false
            errorStr = "Product name can not exceed 255 characters"
        }
        
        if self.infoItem?.chinaName != nil && self.infoItem?.chinaName?.characters.count > 255 {
            complete = false
            errorStr = "Product name in Chinese can not exceed 255 characters"
        }
        
        if self.infoItem?.brand != nil && self.infoItem?.brand?.characters.count > 126 {
            complete = false
            errorStr = "Brand name can not exceed 126 characters"
        }
    
        return (complete, errorStr)
        
    }
}
