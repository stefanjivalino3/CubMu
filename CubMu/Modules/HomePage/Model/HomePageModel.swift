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

struct CategoryResult: Codable {
    var categoryId:String = ""
    var categoryName:String = ""
}



