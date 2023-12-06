//
//  KeyboardContentClipboardViewModel.swift
//  iCliper
//
//  Created by Oran Levi on 06/12/2023.
//

import Foundation
import SwiftData

class KeyboardContentClipboardViewModel: ObservableObject {
    
    private let swiftDataManager = SwiftDataManager.shared
    
    func delete(context: ModelContext, deleteItem: CopiedData){
        swiftDataManager.deleteItem(context: context, item: deleteItem)
    }
}
