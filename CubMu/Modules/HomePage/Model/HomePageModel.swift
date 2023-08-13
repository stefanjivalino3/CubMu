//  
//  HomePageModel.swift
//  Coupski
//
//  Created by Stefan Jivalino on 11/08/23.
//

import Foundation

struct HomePageModel: Codable {
    
}

struct CategoryModel: Codable {
    var result: [CategoryResult]?
    var status: Bool? = false
}

struct CouponModel: Codable {
    var result: [CouponResult]?
    var status: Bool? = false
}

struct CategoryResult: Codable {
    var categoryId:String = ""
    var categoryName:String = ""
}

struct CouponResult: Codable {
    var couponId: String = ""
    var couponBrandName: String = ""
    var couponBenefitType: String = ""
    var couponBenefitValue: String = ""
    var couponCategoryId: String = ""
    var couponEndDate: String = ""
    var couponStatus: String = ""
    var couponBrandLogo: String = ""
    
}



