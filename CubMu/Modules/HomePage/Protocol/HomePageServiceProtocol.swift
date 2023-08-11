//  
//  HomePageServiceProtocol.swift
//  Coupski
//
//  Created by Stefan Jivalino on 11/08/23.
//

import Foundation

protocol HomePageServiceProtocol {

    /// SAMPLE FUNCTION -* Please rename this function to your real function
    ///
    /// - Parameters:
    ///   - success: -- success closure response, add your Model on this closure.
    ///                 example: success(_ data: YourModelName) -> ()
    ///   - failure: -- failure closure response, add your Model on this closure.  
    ///                 example: success(_ data: APIError) -> ()
    func removeThisFuncName(success: @escaping(_ data: HomePageModel) -> (), failure: @escaping() -> ())

}
