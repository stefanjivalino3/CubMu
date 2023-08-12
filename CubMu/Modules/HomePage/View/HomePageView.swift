//  
//  HomePageView.swift
//  Coupski
//
//  Created by Stefan Jivalino on 11/08/23.
//

import UIKit

class HomePageView: UIViewController {

    // OUTLETS HERE
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var categoryCollectionViewCell: UICollectionView!
    
    // VARIABLES HERE
    var viewModel = HomePageViewModel()
    var activeTab = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupCollectionView()
        self.setupView()
        
        self.viewModel.getAllCategory()
    }
    
    private func setupView() {
        view.backgroundColor = .black
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
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryView {
            cell.configureActiveCell()
        }
        
        let diselectIndex = IndexPath(item: activeTab, section: 0)
        
        if let cell = collectionView.cellForItem(at: diselectIndex) as? CategoryView {
            cell.configureDeactiveCell()
        }
        
        activeTab = indexPath.row
        
    }
    
    
}


