//
//  HeaderView.swift
//  Coupski
//
//  Created by Stefan Jivalino on 11/08/23.
//

import UIKit

class HeaderView: UIView {
    let kCONTENT_XIB_NAME = "HeaderView"
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
}
