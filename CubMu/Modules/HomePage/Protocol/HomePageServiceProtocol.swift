//  
//  HomePageServiceProtocol.swift
//  Coupski
//
//  Created by Stefan Jivalino on 11/08/23.
//

import Foundation

protocol HomePageServiceProtocol {
    
    func getCategory(onSuccess: @escaping(CategoryModel) -> Void, onFailure: @escaping((Error)) -> ())
    func getCoupon(onSuccess: @escaping(CouponModel) -> Void, onFailure: @escaping((Error)) -> ())

}
