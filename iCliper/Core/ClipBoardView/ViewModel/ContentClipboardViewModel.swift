//
//  ContentClipboardViewModel.swift
//  iCliper
//
//  Created by Oran Levi on 06/12/2023.
//

import Foundation
import SwiftData

class ContentClipboardViewModel: ObservableObject {
    
    
    private let service = Service.shared
    private let swiftDataManager = SwiftDataManager.shared
    
    func copyButton(text: String){
        service.copy(text: text)
    }
    
    func delete(context: ModelContext, deleteItem: CopiedData){
        swiftDataManager.deleteItem(context: context, item: deleteItem)
    }
    
}
