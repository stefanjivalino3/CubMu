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
        let escapeUrl = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        self.kf.setImage(with: URL(string: escapeUrl))
    }
}
