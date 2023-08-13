//
//  CouponDetailView.swift
//  CubMu
//
//  Created by Stefan Jivalino on 13/08/23.
//

import UIKit

class CouponDetailView: UIViewController {
    @IBOutlet weak var bottomBgView: UIView!
    @IBOutlet weak var brandImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var couponDetail = CouponResult()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        brandImageView.showImageFromUrl(url: couponDetail.couponBrandLogo)
        titleLabel.text = couponDetail.couponBrandName
        
        if couponDetail.couponBenefitType == "Discount" {
            valueLabel.text = couponDetail.couponBenefitValue
        } else {
            valueLabel.isHidden = true
        }
        bottomBgView.layer.cornerRadius = 32
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterDate = DateFormatter()
        dateFormatterDate.dateFormat = "d MMMM yyyy"
        dateFormatterDate.locale = Locale(identifier: "id_ID")
        
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.dateFormat = "HH:mm"
        dateFormatterTime.locale = Locale(identifier: "id_ID")
        

        if let date = dateFormatterGet.date(from: couponDetail.couponEndDate) {
            subtitleLabel.text = "Promo Sampai \(dateFormatterDate.string(from: date))"
            timeLabel.text = dateFormatterTime.string(from: date)
        }
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        if self.sheetViewController?.options.useInlineMode == true {
            self.sheetViewController?.attemptDismiss(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
