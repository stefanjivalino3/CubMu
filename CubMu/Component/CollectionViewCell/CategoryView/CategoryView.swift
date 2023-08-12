//
//  CategoryView.swift
//  CubMu
//
//  Created by Stefan Jivalino on 12/08/23.
//

import UIKit

class CategoryView: UICollectionViewCell {

    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(categoryTitle: String) {
        categoryLabel.text = categoryTitle
    }
    
    func configureActiveCell() {
        bottomLineView.backgroundColor = UIColor(rgb: 0xCE544F)
        categoryLabel.textColor = .white
    }
    
    func configureDeactiveCell() {
        bottomLineView.backgroundColor = UIColor(rgb: 0x68696A)
        categoryLabel.textColor = UIColor(rgb: 0xB1B2B3)
    }

}
