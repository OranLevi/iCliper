//
//  Service.swift
//  iCliper
//
//  Created by Oran Levi on 27/11/2023.
//

import SwiftUI
import SwiftData

class Service {
    
    static let shared = Service()
    let swiftDataManager = SwiftDataManager.shared
    
    func gettingCopied(context: ModelContext,text: String){
            swiftDataManager.addItem(context: context, text: text)
    }
    
    func copy(text: String){
        let pasteBoard = UIPasteboard.general
           pasteBoard.string = text
    }

}
