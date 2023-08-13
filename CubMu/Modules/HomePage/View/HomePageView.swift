//  
//  HomePageView.swift
//  Coupski
//
//  Created by Stefan Jivalino on 11/08/23.
//

import UIKit

class HomePageView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var emptyStateView: EmptyStateView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var categoryCollectionViewCell: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    // VARIABLES HERE
    var viewModel = HomePageViewModel()
    var activeTab = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupCollectionView()
        self.setupTableView()
        self.setupView()
        
        self.viewModel.getAllCategory()
        self.viewModel.getCoupon(coupunType: 0)
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(rgb: 0x1E1F26)
        
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .black
        tableView.registerNIB(with: CouponCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupCollectionView() {
        categoryCollectionViewCell.registerNIBForCell(with: CategoryView.self)
        
        if let layout = categoryCollectionViewCell.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize(width: view.frame.width, height: 52)
            layout.itemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        categoryCollectionViewCell.backgroundColor = UIColor(rgb: 0x1E1F26)
        categoryCollectionViewCell.delegate = self
        categoryCollectionViewCell.dataSource = self
        categoryCollectionViewCell.isHidden = true
    }
    
    fileprivate func setupViewModel() {

        self.viewModel.showAlertClosure = {
            let alert = self.viewModel.alertMessage ?? ""
            print(alert)
        }
        
        self.viewModel.updateLoadingStatus = {
            if self.viewModel.isLoading {
                print("LOADING...")
            } else {
                 print("DATA READY")
            }
        }

        self.viewModel.internetConnectionStatus = {
            print("Internet disconnected")
            // show UI Internet is disconnected
        }

        self.viewModel.serverErrorStatus = {
            print("Server Error / Unknown Error")
            // show UI Server is Error
        }

        self.viewModel.didGetAllCategory = { [weak self] in
            self?.categoryCollectionViewCell.reloadData()
            self?.categoryCollectionViewCell.isHidden = false
        }
        
        self.viewModel.didGetCoupon = { [weak self] in
            if self?.viewModel.couponData.count == 0 {
                self?.emptyStateView.isHidden = false
            } else {
                self?.emptyStateView.isHidden = true
            }
            self?.tableView.reloadData()
        }

    }
    
}

extension HomePageView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.couponData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: CouponCell.self)!
        cell.selectionStyle = .none
        
        cell.configureCell(couponImage: viewModel.couponData[indexPath.row].couponBrandLogo,
                           couponBrandName: viewModel.couponData[indexPath.row].couponBrandName,
                           couponBenefitType: viewModel.couponData[indexPath.row].couponBenefitType,
                           couponBenefitValue: viewModel.couponData[indexPath.row].couponBenefitValue,
                           couponEndDate: viewModel.couponData[indexPath.row].couponEndDate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }


}

extension HomePageView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.categoryData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: CategoryView.self, for: indexPath)!
        
        if indexPath.row == 0 {
            cell.categoryLabel.text = "All"
        } else {
            cell.configureCell(categoryTitle: self.viewModel.categoryData[indexPath.row - 1].categoryName)
        }
        
        if indexPath.row == activeTab {
            cell.configureActiveCell()
        } else {
            cell.configureDeactiveCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let diselectIndex = IndexPath(item: activeTab, section: 0)
        
        if let cell = collectionView.cellForItem(at: diselectIndex) as? CategoryView {
            cell.configureDeactiveCell()
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryView {
            cell.configureActiveCell()
        }
        
        if indexPath.row == 0 {
            if indexPath.row != self.activeTab {
                self.viewModel.getCoupon(coupunType: 0)
                self.tableView.reloadData()
            }
        } else {
            if indexPath.row != self.activeTab {
                self.viewModel.getCoupon(coupunType: Int(self.viewModel.categoryData[indexPath.row - 1].categoryId) ?? 0)
                self.tableView.reloadData()
            }
        }
        
        activeTab = indexPath.row
        
        
        
        
    }
    
    
}


