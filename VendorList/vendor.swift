//
//  vendor.swift
//  VendorList
//
//  Created by Swati Wadhera on 11/7/17.
//  Copyright © 2017 Swati Wadhera. All rights reserved.
//

import UIKit
import Foundation

let vendorName = "name"
let vendorCity = "city"
let vendorPrice = "vendor_price"
let vendorImgURL = "profile_pic_url"
let vendorReviewsCount = "reviews_count"
let vendorRating = "vendor_rating"

class vendor: NSObject {

    var name : String
    var city : String
    var price : String
    var imgUrl : String
    var reviews : String
    var rating : String
    
    init(json: [String: Any]) {
        name = json[vendorName] as! String
        city = json[vendorCity] as! String
        price = json[vendorPrice] as! String
        imgUrl = json[vendorImgURL] as! String
        reviews = json[vendorReviewsCount] as! String
        rating = json[vendorRating] as! String
    }
}
