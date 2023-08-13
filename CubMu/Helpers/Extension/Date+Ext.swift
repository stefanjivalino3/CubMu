//
//  Date+Ext.swift
//  CubMu
//
//  Created by Stefan Jivalino on 13/08/23.
//

import Foundation

extension Date {
    public var dateToFullDayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        
        // Force specific and consistent DateFormatter settings
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(abbreviation: "WIT")
        formatter.locale = Locale(identifier: "id_ID")
        
        return formatter.string(from: self)
    }
}
