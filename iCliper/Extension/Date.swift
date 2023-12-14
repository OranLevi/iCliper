//
//  Date.swift
//  iCliper
//
//  Created by Oran Levi on 12/12/2023.
//

import SwiftUI

extension Date {
    
    func formattedDate(inputDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: inputDate)
    }
}
