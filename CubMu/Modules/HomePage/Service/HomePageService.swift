//  
//  HomePageService.swift
//  Coupski
//
//  Created by Stefan Jivalino on 11/08/23.
//

import Foundation
import Alamofire

class HomePageService: HomePageServiceProtocol {
    
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
