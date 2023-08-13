//  
//  HomePageService.swift
//  Coupski
//
//  Created by Stefan Jivalino on 11/08/23.
//

import Foundation
import Alamofire

class HomePageService: HomePageServiceProtocol {
    func getCoupon(onSuccess: @escaping (CouponModel) -> Void, onFailure: @escaping ((Error)) -> ()) {
        let url = "https://user1673281842743.requestly.dev/getCoupon"
        
        AF.request(
            url,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: nil,
            interceptor: nil
        ).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(CouponModel.self, from: data)
                    onSuccess(result)
                } catch {
                    onFailure(error)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func getCategory(onSuccess: @escaping(CategoryModel) -> Void, onFailure: @escaping((Error)) -> ()) {

        let url = "https://user1673281842743.requestly.dev/getAllCategory"
        
        AF.request(
            url,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: nil,
            interceptor: nil
        ).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(CategoryModel.self, from: data)
                    onSuccess(result)
                } catch {
                    onFailure(error)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
}

class HomePageMockService: HomePageServiceProtocol {
    func getCategory(onSuccess: @escaping (CategoryModel) -> Void, onFailure: @escaping ((Error)) -> ()) {
        let response = CategoryModel(result: [
            CategoryResult(
                categoryId: "1",
                categoryName: "Food"
            )], status: true
        )
        onSuccess(response)
    }
    
    func getCoupon(onSuccess: @escaping (CouponModel) -> Void, onFailure: @escaping ((Error)) -> ()) {
        let response = CouponModel(result: [
            CouponResult(
                couponId: "1",
                couponBrandName: "Wendy's",
                couponBenefitType: "Discount",
                couponBenefitValue: "20%",
                couponCategoryId: "1",
                couponEndDate: "01-01-2020 00:00:00",
                couponStatus: "active",
                couponBrandLogo: "www.image.com"
            )], status: true
        )
        onSuccess(response)
        
        onSuccess(response)
    }
    
    
}
