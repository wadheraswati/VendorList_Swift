//
//  vendor.swift
//  VendorList
//
//  Created by Swati Wadhera on 11/7/17.
//  Copyright © 2017 Swati Wadhera. All rights reserved.
//

import UIKit
import Foundation

class vendor: NSObject {

    var name : String
    var city : String
    var price : String
    var imgUrl : String
    
    init(json: [String: Any]) {
        name = json["name"] as! String
        city = json["city"] as! String
        price = json["vendor_price"] as! String
        imgUrl = json["profile_pic_url"] as! String
    }
}
