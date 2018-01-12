//
//  vendorCell.swift
//  VendorList
//
//  Created by Swati Wadhera on 10/13/17.
//  Copyright © 2017 Swati Wadhera. All rights reserved.
//

import UIKit

class vendorCell: UITableViewCell {

    var borderView = UIView()
    var coverPicImgV = UIImageView()
    var nameLbl = UILabel()
    var cityLbl = UILabel()
    var priceLbl = UILabel()
    var reviewLbl = UILabel()
    var starLbl = UILabel()
    
    
    var multiplicationFactor : CGFloat = 9/16
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = 2
        self.backgroundColor = .clear
        
        self.clipsToBounds = false
        
        borderView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height - 10))
        borderView.backgroundColor = .white
        self.addSubview(borderView)
        
        coverPicImgV = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.width*multiplicationFactor))
        coverPicImgV.backgroundColor = .lightGray
        coverPicImgV.clipsToBounds = true
        self.addSubview(coverPicImgV)
        
        nameLbl = UILabel(frame: CGRect(x: 5, y: coverPicImgV.frame.origin.y + coverPicImgV.frame.size.height + 5, width: self.bounds.size.width - 10, height: 20))
        nameLbl.font = UIFont.boldSystemFont(ofSize: 15)
        nameLbl.textColor = .black
        nameLbl.textAlignment = NSTextAlignment.left
        self.addSubview(nameLbl)
        
        cityLbl = UILabel(frame: CGRect(x: 5, y: nameLbl.frame.origin.y + nameLbl.frame.size.height + 5, width: self.bounds.size.width - 10, height: 15))
        cityLbl.font = UIFont.boldSystemFont(ofSize: 12)
        cityLbl.textColor = UIColor.black.withAlphaComponent(0.5)
        cityLbl.textAlignment = NSTextAlignment.left
        self.addSubview(cityLbl)
        
        priceLbl = UILabel(frame: CGRect(x: 5, y: priceLbl.frame.origin.y + priceLbl.frame.size.height + 5, width: self.bounds.size.width - 10, height: 15))
        priceLbl.font = UIFont.boldSystemFont(ofSize: 12)
        priceLbl.textColor = .red
        priceLbl.textAlignment = NSTextAlignment.left
        self.addSubview(priceLbl)
        
        starLbl = UILabel(frame : CGRect(x: 0, y: nameLbl.frame.origin.y, width: 100, height: nameLbl.frame.size.height))
        starLbl.font = UIFont.boldSystemFont(ofSize: 12)
        starLbl.backgroundColor = .green
        starLbl.textColor = cityLbl.textColor
        starLbl.text = "★ 4.5"
        starLbl.textAlignment = .center
        starLbl.layer.cornerRadius = 2
        starLbl.clipsToBounds = true
        self.addSubview(starLbl)
        
        reviewLbl = UILabel(frame: CGRect(x: 0, y: cityLbl.frame.origin.y, width: 100, height: cityLbl.frame.size.height))
        reviewLbl.textColor = UIColor.black.withAlphaComponent(0.5)
        reviewLbl.font = priceLbl.font
        reviewLbl.textAlignment = .right
        self.addSubview(reviewLbl)
        
        
    }
    
    override func layoutSubviews() {
        borderView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height - 10)
        coverPicImgV.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.width*multiplicationFactor)
        nameLbl.frame = CGRect(x: 5, y: coverPicImgV.frame.origin.y + coverPicImgV.frame.size.height + 5, width: self.bounds.size.width - 10, height: 20)
        cityLbl.frame = CGRect(x: 5, y: nameLbl.frame.origin.y + nameLbl.frame.size.height, width: self.bounds.size.width - 10, height: 20)
        priceLbl.frame = CGRect(x: 5, y: cityLbl.frame.origin.y + cityLbl.frame.size.height, width: self.bounds.size.width - 10, height: 20)
        starLbl.sizeToFit()
        starLbl.frame = CGRect(x: self.bounds.size.width - starLbl.bounds.size.width - 15, y: nameLbl.frame.origin.y, width: starLbl.bounds.size.width + 10, height: starLbl.frame.size.height)
        reviewLbl.sizeToFit()
        reviewLbl.frame = CGRect(x: self.bounds.size.width - reviewLbl.bounds.size.width - 5, y: cityLbl.frame.origin.y, width: reviewLbl.bounds.size.width, height: reviewLbl.frame.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
