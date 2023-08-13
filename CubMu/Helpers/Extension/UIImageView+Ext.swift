//
//  UIImageView+Ext.swift
//  CubMu
//
//  Created by Stefan Jivalino on 12/08/23.
//

import Kingfisher
import UIKit

extension UIImageView {
    func showImageFromUrl(url: String) {
        self.kf.setImage(with: URL(string: url))
    }
}
