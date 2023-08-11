//
//  BaseNavigationController.swift
//  Coupski
//
//  Created by Stefan Jivalino on 11/08/23.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11, *) {
            navigationBar.isTranslucent = true
            navigationBar.barTintColor = UIColor.clear
            navigationBar.backgroundColor = UIColor.clear
        } else {
            navigationBar.isTranslucent = false
            navigationBar.barTintColor = UIColor.white
            navigationBar.backgroundColor = UIColor.white
        }
//        navigationBar.tintColor = UIColor(named: "Primary_greenPrimary")!
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 5)),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]

        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
    }
}

extension UINavigationController {
    func makeTransparentBackgroundForNavigationBar() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        } else {
            navigationBar.isTranslucent = true
            navigationBar.barTintColor = UIColor.clear
            navigationBar.backgroundColor = UIColor.clear
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        }
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func makeSolidBackgroundForNavigationBar() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        } else {
            navigationBar.isTranslucent = false
            navigationBar.barTintColor = UIColor.white
            navigationBar.backgroundColor = UIColor.white
            navigationBar.setBackgroundImage(nil, for: .default)
            navigationBar.shadowImage = nil
        }
        setNeedsStatusBarAppearanceUpdate()
    }
}
