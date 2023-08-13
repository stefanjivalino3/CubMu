//
//  EmptyStateView.swift
//  CubMu
//
//  Created by Stefan Jivalino on 13/08/23.
//

import UIKit

class EmptyStateView: UIView {
    @IBOutlet var contentView: UIView!
    let kCONTENT_XIB_NAME = "EmptyStateView"
    
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
