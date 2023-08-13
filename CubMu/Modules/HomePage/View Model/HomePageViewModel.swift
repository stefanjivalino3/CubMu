//  
//  HomePageViewModel.swift
//  Coupski
//
//  Created by Stefan Jivalino on 11/08/23.
//

import Foundation

class HomePageViewModel {

    private let service: HomePageServiceProtocol

    private var model: [HomePageModel] = [HomePageModel]() {
        didSet {
            self.count = self.model.count
        }
    }

    var categoryData = [CategoryResult]()
    var couponData = [CouponResult]()
    
    /// Count your data in model
    var count: Int = 0

    //MARK: -- Network checking

    /// Define networkStatus for check network connection
    var networkStatus = Reach().connectionStatus()

    /// Define boolean for internet status, call when network disconnected
    var isDisconnected: Bool = false {
        didSet {
            self.alertMessage = "No network connection. Please connect to the internet"
            self.internetConnectionStatus?()
        }
    }

    //MARK: -- UI Status

    /// Update the loading status, use HUD or Activity Indicator UI
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    /// Showing alert message, use UIAlertController or other Library
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    /// Define selected model
    var selectedObject: HomePageModel?

    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?
    
    var didGetAllCategory: (() -> ())?
    var didErrorGetAllCategory: (() -> ())?
    var didGetCoupon: (() -> ())?
    var didErrorGetCoupon: (() -> ())?

    init(withHomePage serviceProtocol: HomePageServiceProtocol = HomePageService() ) {
        self.service = serviceProtocol

        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()

    }

    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }

    //MARK: -- Example Func
    func exampleBind() {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            self.isLoading = false
        default:
            break
        }
    }
    
    func getAllCategory() {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            service.getCategory() { [weak self] res in
                if res.status == false {
                    self?.didErrorGetAllCategory?()
                } else {
                    self?.categoryData = res.result ?? [CategoryResult]()
                    self?.didGetAllCategory?()
                }
            } onFailure: { [weak self] error in
                guard self != nil else {return}
                print(error.localizedDescription)
                self?.didErrorGetAllCategory?()
            }
        default:
            break
        }
    }
    
    func getCoupon(coupunType: Int) {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            service.getCoupon() { [weak self] res in
                if res.status == false {
                    self?.didErrorGetAllCategory?()
                } else {
                    self?.couponData = res.result ?? [CouponResult]()
                    
                    if coupunType > 0 {
                        self?.couponData = self?.couponData.filter {
                            $0.couponCategoryId == String(coupunType)
                        } ?? [CouponResult]()
                    }
                    self?.didGetCoupon?()
                }
            } onFailure: { [weak self] error in
                guard self != nil else {return}
                print(error.localizedDescription)
                self?.didErrorGetCoupon?()
            }
        default:
            break
        }
    }

}

extension HomePageViewModel {

}
