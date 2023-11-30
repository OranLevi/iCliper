//
//  HowToUseViewModel.swift
//  iCliper
//
//  Created by Oran Levi on 30/11/2023.
//

import Foundation

class HowToUseViewModel: ObservableObject {
    
    var currentLanguage: String {
        guard let languageCode = Locale.current.language.languageCode?.identifier else {
             return "Unknown"
         }
        return languageCode.uppercased()
     }
}
