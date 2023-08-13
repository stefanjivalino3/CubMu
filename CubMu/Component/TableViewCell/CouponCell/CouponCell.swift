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
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var buttonLabel: UILabel!
    
    var didTapButton: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    private func setupView() {
        bgView.layer.cornerRadius = 8
        buttonView.layer.cornerRadius = 4
        
        couponImageView.layer.cornerRadius = 8
        couponImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
    }
    
    func configureCell(couponImage: String, couponBrandName: String, couponBenefitType: String, couponBenefitValue: String, couponEndDate: String) {
        
        couponImageView.showImageFromUrl(url: couponImage)
        titleLabel.text = couponBrandName
        benefitLabel.text = couponBenefitValue
        if couponBenefitType != "Discount" {
            benefitDescLabel.isHidden = true
        } else {
            benefitDescLabel.isHidden = false
        }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "d MMMM yyyy"
        dateFormatterPrint.locale = Locale(identifier: "id_ID")
        
        var endDate = ""

        if let date = dateFormatterGet.date(from: couponEndDate) {
            endDate = dateFormatterPrint.string(from: date)
        }
        
        dueDateLabel.text = "Promo Sampai \(endDate) "
    }
    
    func disableButton() {
        buttonView.backgroundColor = UIColor(rgb: 0xC4C4C4)
        buttonLabel.textColor = UIColor(rgb: 0xF0F0F0)
        redeemButton.isUserInteractionEnabled = false
        
    }
    
    func enableButton() {
        buttonView.backgroundColor = UIColor(rgb: 0x26D27F)
        buttonLabel.textColor = .white
        redeemButton.isUserInteractionEnabled = true
        
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        redeemButton.titleLabel?.font = UIFont(name: "Mulish-SemiBold", size: 12)
        didTapButton?()
    }
}
