//
//  CopiedData.swift
//  iCliper
//
//  Created by Oran Levi on 26/11/2023.
//

import Foundation
import SwiftData

@Model
class CopiedData: Identifiable {
    
    var id: String
    var text: String
    var date: Date = Date.now
    
    init(text: String) {
        self.id = UUID().uuidString
        self.text = text
        self.date = date
    }
}
