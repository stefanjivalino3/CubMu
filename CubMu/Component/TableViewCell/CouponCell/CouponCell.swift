//
//  CouponCell.swift
//  CubMu
//
//  Created by Stefan Jivalino on 12/08/23.
//

import UIKit

class CouponCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var couponImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var benefitLabel: UILabel!
    @IBOutlet weak var benefitDescLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var redeemButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    private func setupView() {
        bgView.layer.cornerRadius = 8
        redeemButton.layer.cornerRadius = 4
        redeemButton.titleLabel?.font = UIFont(name: "Mulish-SemiBold", size: 12)
        
        couponImageView.layer.cornerRadius = 8
        couponImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
    }
    
    func configureCell(couponImage: String, couponBrandName: String, couponBenefitType: String, couponBenefitValue: String, couponEndDate: String) {
        
        let escapeUrl = couponImage.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        couponImageView.showImageFromUrl(url: escapeUrl ?? "")
        titleLabel.text = couponBrandName
        benefitLabel.text = couponBenefitValue
        if couponBenefitType != "Discount" {
            benefitDescLabel.isHidden = true
        } else {
            benefitDescLabel.isHidden = false
        }
        dueDateLabel.text = couponEndDate
    }
    
}
