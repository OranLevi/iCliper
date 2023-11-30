//
//  ClipBoardViewModel.swift
//  iCliper
//
//  Created by Oran Levi on 27/11/2023.
//

import SwiftUI
import SwiftData

class ClipBoardViewModel: ObservableObject {
    
    @Published var searchText:String = ""
    
    let service = Service.shared
    let swiftDataManager = SwiftDataManager.shared
    
    func gettingCopied(items: [CopiedData], context: ModelContext) {
        let pasted = UIPasteboard.general.string
        if items.contains(where: { $0.text == pasted }) {
            return
        } else {
            if let textPasted = pasted {
                service.gettingCopied(context: context,text: textPasted)
            }
        }
    }
    
    func disableButtonEmptyArray(items: [CopiedData]) -> Bool {
        if searchText == "" && items.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func copyButton(text: String){
        service.copy(text: text)
    }
    
    func delete(context: ModelContext, deleteItem: CopiedData){
        swiftDataManager.deleteItem(context: context, item: deleteItem)
    }
    
    
}
