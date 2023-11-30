//
//  HowToUseViewModel.swift
//  iCliper
//
//  Created by Oran Levi on 30/11/2023.
//

import Foundation

class HowToUseViewModel: ObservableObject {
    
    @Published var isVideoEnd: Bool = false
    @Published var isClickPlay: Bool = false
    
    init(){
        NotificationCenter.default.addObserver(
              self,
              selector: #selector(fileComplete),
              name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
              object: nil
          )
    }
    
    @objc func fileComplete() {
        isVideoEnd = true
        isClickPlay = false
        print("one video has reached -0 time")
    }
    
    var currentLanguage: String {
        guard let languageCode = Locale.current.language.languageCode?.identifier else {
             return "Unknown"
         }
        return languageCode.uppercased()
     }
}
