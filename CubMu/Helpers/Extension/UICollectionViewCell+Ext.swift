//
//  UICollectionViewCell+Ext.swift
//  CubMu
//
//  Created by Stefan Jivalino on 12/08/23.
//

import UIKit

extension UICollectionView {
    func registerNIBForCell(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        self.register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
    }
    
    func dequeueCell<T>(with cellClass: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T
    }
    
    func registerNIBForHeader(with cellClass: AnyClass) {
        let className = String(describing: cellClass)
        self.register(UINib(nibName: className, bundle: nil),
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: className)
    }
    
    func dequeueHeader<T>(with cellClass: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                withReuseIdentifier: String(describing: cellClass),
                                                for: indexPath) as? T
    }
}
